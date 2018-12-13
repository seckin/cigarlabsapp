
import UIKit
import Parse

class AuthenticatedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate {

    @IBOutlet weak var tableViewPosts: UITableView!
    var refreshControl: UIRefreshControl!
    var feed: [PFObject] = []
    @IBOutlet weak var noDevicesLabel: UILabel!
    
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
        post.saveInBackground()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = feed[indexPath.row]
        let caption = post["caption"] as! String

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView

        print(cell.colorHolder.bounds.size.height)

        cell.colorHolder.setTitle("",for: .normal)
        cell.colorHolder.layer.cornerRadius = cell.colorHolder.bounds.size.height / 2
        cell.colorHolder.layer.backgroundColor = UIColor.clear.cgColor

        cell.colorHolder.layer.borderColor = UIColor.gray.cgColor
        cell.colorHolder.layer.borderWidth = 2.0

        cell.captionLabel.text = caption

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
    }
    */
    
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
