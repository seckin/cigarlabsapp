//
//  ProfileViewController.swift
//  Instagram
//
//  Created by NICK on 2/9/18.
//  Copyright © 2018 NICK. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var userImageView: PFImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var postNumberLabel: UILabel!
    var refreshControl: UIRefreshControl!
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        if refreshControl != nil {
            collectionView.insertSubview(refreshControl, at: 0)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Sets circle profile picture viewer
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        
        refresh()
    }
    
    func refreshProfileInfo() {
        if let user = PFUser.current(){
            //userLabel.text = user.username
            nameLabel.text = user["name"] as? String
            bioLabel.text = user["bio"] as? String
            self.title = user.username// sets navBar title
            userImageView.file = user["image"] as? PFFile
            userImageView.loadInBackground()
        }
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    
    func refresh() {
        var posts: [PFObject] = []
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.includeKey("author")
        // limit to current author
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if var posts = posts {
                    for post in posts {
                        posts.append(post)
                    }
                    self.posts = posts
                    self.collectionView.reloadData()
                    self.postNumberLabel.text = String(posts.count)
                    print("Feed reloaded")
                }
            }
        }
        refreshProfileInfo()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    class UserCell: UICollectionViewCell {
        
        @IBOutlet weak var photoView: PFImageView!
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCell
        let post = posts[indexPath.item]
        let image = post["media"] as! PFFile
        cell.photoView.file = image
        cell.photoView.loadInBackground()
        return cell
    }

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
