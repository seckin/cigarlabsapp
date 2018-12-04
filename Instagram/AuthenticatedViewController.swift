//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by NICK on 2/4/18.
//  Copyright © 2018 NICK. All rights reserved.
//

import UIKit
import Parse

class AuthenticatedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate {
    
    
    @IBOutlet weak var tableViewPosts: UITableView!
    var refreshControl: UIRefreshControl!
    var feed: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.tableView.dataSource = self
        //Refresh Control Initialized
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        if refreshControl != nil {
            tableViewPosts.insertSubview(refreshControl, at: 0)
        }
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        tableViewPosts.separatorStyle = .none
        
        pullRefresh()
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.logOut()
        print("Logout Pressed")
        /*
         PFUser.logOutInBackgroundWithBlock { (error:NSError?) in
         // PFUser.current() will now be nil
         } */
    }
    
    
    func pullRefresh() {
        var feedPosts: [PFObject] = []
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let posts = posts {
                    for post in posts {
                        feedPosts.append(post)
                    }
                    self.feed = feedPosts
                    self.tableViewPosts.reloadData()
                    print("Feed reloaded")
                }
            }
        }
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        pullRefresh()
        refreshControl.endRefreshing()
    }
    
    
    // from PostTableViewCellDelegate
    func postCell(_ cell: PostTableViewCell, didLike post: PFObject?) {
        print("called postcell")
        let indexPath = tableViewPosts.indexPath(for: cell)!
        let post = feed[indexPath.row]
        let likes = (post["likesCount"] as? Int)! + 1
        post["likesCount"] = likes
        post.saveInBackground()
        cell.likeButton.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = feed[indexPath.row]
        let caption = post["caption"] as! String
        let image = post["media"] as! PFFile
        let author = post["author"] as! PFUser
        let likeCount = post["likesCount"] as! Int
        
        // on like, add current user to list of users who liked the post and
        // change the displayed icon by pulling from API
        cell.likesLabel.text = String(likeCount)
        cell.captionLabel.text = caption
        cell.photoView.file = image
        cell.photoView.loadInBackground()
        cell.userLabel.text = author.username
        cell.userLabel2.text = author.username
        cell.userView.file = author["image"] as? PFFile
        cell.userView.loadInBackground()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableViewPosts.indexPath(for: cell) {
            let post = feed[indexPath.row]
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.post = post
        }
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        let hidden = self.navigationController?.isNavigationBarHidden
        print(hidden)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
