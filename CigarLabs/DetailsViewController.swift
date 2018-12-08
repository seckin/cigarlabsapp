
import UIKit
import Parse

class DetailsViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var setCountLabel: UILabel!

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var smallCircleSettingButton: UIButton!
    @IBOutlet weak var bigCircleSettingButton: UIButton!

    var currentHumidity: Int!
    var setButtonCount: Int! // TODO: initialize this to the number read from the DB

    var post: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let post = post {
            let caption = post["caption"] as? String
            let author = post["author"] as? PFUser

            // Sets circle profile picture viewer
//            userView.layer.borderWidth = 1
//            userView.layer.masksToBounds = false
//            userView.layer.borderColor = UIColor.white.cgColor
//            userView.layer.cornerRadius = userView.frame.height/2
//            userView.clipsToBounds = true

            captionLabel.text = caption
            userLabel.text = author?.username

            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 350), radius: CGFloat(100), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            //change the fill color
            shapeLayer.fillColor = UIColor.clear.cgColor
            //you can change the stroke color
            shapeLayer.strokeColor = UIColor.gray.cgColor
            //you can change the line width
            shapeLayer.lineWidth = 3.0
            view.layer.addSublayer(shapeLayer)



            currentHumidity = post["temperature"] as? Int
            setButtonCount = currentHumidity
//            let size:CGFloat = 55.0

//            let countLabel = UILabel(frame: CGRect(x : 0.0,y : 0.0,width : size, height :  size))
            countLabel.text = String(currentHumidity)
            countLabel.textColor = UIColor.darkGray
            countLabel.textAlignment = .center
//            countLabel.font = UIFont.systemFont(ofSize: 24.0)
//            countLabel.layer.cornerRadius = size / 2
//            countLabel.layer.borderWidth = 3.0
//            countLabel.layer.masksToBounds = true
//            countLabel.layer.backgroundColor = UIColor.orange.cgColor
//            countLabel.layer.borderColor = UIColor.orange.cgColor


            let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 515), radius: CGFloat(50), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let smallShapeLayer = CAShapeLayer()
            smallShapeLayer.path = smallCirclePath.cgPath
            //change the fill color
            smallShapeLayer.fillColor = UIColor.clear.cgColor
            //you can change the stroke color
            smallShapeLayer.strokeColor = UIColor.gray.cgColor
            //you can change the line width
            smallShapeLayer.lineWidth = 2.0
            view.layer.addSublayer(smallShapeLayer)

            //            let setCountLabel = UILabel(frame: CGRect(x : 0.0,y : 0.0,width : size, height :  size))
            let myCountLabelString = "SET\u{000A} " + String(setButtonCount)
            let myCountLabelAttribute = [NSFontAttributeName: UIFont(name: "Verdana", size: 22)!]
            let myCountLabelAttrString = NSAttributedString(string: myCountLabelString, attributes: myCountLabelAttribute)
            // set attributed text on a UILabel
            setCountLabel.attributedText = myCountLabelAttrString
            setCountLabel.textColor = UIColor.darkGray
            setCountLabel.textAlignment = .center
            //            setCountLabel.font = UIFont.systemFont(ofSize: 24.0)
            //            setCountLabel.layer.cornerRadius = size / 2
            //            setCountLabel.layer.borderWidth = 3.0
            //            setCountLabel.layer.masksToBounds = true
            //            setCountLabel.layer.backgroundColor = UIColor.orange.cgColor
            //            setCountLabel.layer.borderColor = UIColor.orange.cgColor

            let myString = "\u{2303}"
            let myAttribute = [NSFontAttributeName: UIFont(name: "Verdana", size: 37)!]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            // set attributed text on a UILabel
            upLabel.attributedText = myAttrString

            let myString2 = "\u{2304}"
            let myAttribute2 = [NSFontAttributeName: UIFont(name: "Verdana", size: 37)!]
            let myAttrString2 = NSAttributedString(string: myString2, attributes: myAttribute2)
            // set attributed text on a UILabel
            downLabel.attributedText = myAttrString2
        }
    }

    @IBAction func CigarLabsBackButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "DetailView", sender: nil)
        
    }

    @IBAction func upButtonTapped(_ sender: Any) {
        setButtonCount += 1
        let myCountLabelString = "SET\u{000A} " + String(setButtonCount)
        let myCountLabelAttribute = [NSFontAttributeName: UIFont(name: "Verdana", size: 22)!]
        let myCountLabelAttrString = NSAttributedString(string: myCountLabelString, attributes: myCountLabelAttribute)
        // set attributed text on a UILabel
        setCountLabel.attributedText = myCountLabelAttrString
        setCountLabel.textColor = UIColor.darkGray
        setCountLabel.textAlignment = .center
    }

    @IBAction func downButtonTapped(_ sender: Any) {
        setButtonCount -= 1
        let myCountLabelString = "SET\u{000A} " + String(setButtonCount)
        let myCountLabelAttribute = [NSFontAttributeName: UIFont(name: "Verdana", size: 22)!]
        let myCountLabelAttrString = NSAttributedString(string: myCountLabelString, attributes: myCountLabelAttribute)
        // set attributed text on a UILabel
        setCountLabel.attributedText = myCountLabelAttrString
        setCountLabel.textColor = UIColor.darkGray
        setCountLabel.textAlignment = .center
    }

    @IBAction func setButtonTapped(_ sender: Any) {
        if let post = post {
            post["temperature"] = setButtonCount
    //        ProgressHUD.showSuccess("Update successful")
            post.saveInBackground()

//            post.saveInBackground { (success: Bool, error: Error?) in
//                completion?(success, error)
//            }
        }

        // TODO: make a db call
        currentHumidity = setButtonCount
        countLabel.text = String(currentHumidity)
        countLabel.textColor = UIColor.darkGray
        countLabel.textAlignment = .center
    }

    @IBAction func bigCircleTapped(_ sender: Any) {
        // TODO: show the settings page
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
        let post = self.post
        let humidifierSettingsViewController = segue.destination as! HumidifierSettingsViewController
        humidifierSettingsViewController.post = post
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
