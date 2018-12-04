//
//  DetailsViewController.swift
//  Instagram
//
//  Created by NICK on 2/9/18.
//  Copyright © 2018 NICK. All rights reserved.
//

import UIKit
import Parse

class DetailsViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userLabel2: UILabel!
    @IBOutlet weak var userView: PFImageView!
    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let post = post {
            let caption = post["caption"] as! String
            let image = post["media"] as! PFFile
            let author = post["author"] as! PFUser
            let date = post.createdAt
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date!)
            let likeCount = post["likesCount"] as! Int
            
            // Sets circle profile picture viewer
            userView.layer.borderWidth = 1
            userView.layer.masksToBounds = false
            userView.layer.borderColor = UIColor.white.cgColor
            userView.layer.cornerRadius = userView.frame.height/2
            userView.clipsToBounds = true
            
            likesLabel.text = String(likeCount)
            captionLabel.text = caption
            photoView.file = image
            photoView.loadInBackground()
            userLabel.text = author.username
            userLabel2.text = author.username
            timestampLabel.text = dateString
            userView.file = author["image"] as? PFFile
            userView.loadInBackground()
        }
    }
    
    
    @IBAction func InstagramBackButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "DetailView", sender: nil)
        
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
