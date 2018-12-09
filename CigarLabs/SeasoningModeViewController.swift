
import UIKit
import Parse

class SeasoningModeViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var setCountLabel: UILabel!

    var currentHumidity: Int!
    var setButtonCount: Int! // TODO: initialize this to the number read from the DB

    var post: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            let caption = post["caption"] as? String
            let author = post["author"] as? PFUser

            captionLabel.text = caption
            userLabel.text = author?.username

            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 350), radius: CGFloat(100), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.lineWidth = 3.0
            view.layer.addSublayer(shapeLayer)


            currentHumidity = 80
            //post["temperature"] as? Int
            setButtonCount = currentHumidity
            countLabel.text = String(currentHumidity)
            countLabel.textColor = UIColor.darkGray
            countLabel.textAlignment = .center

            let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 515), radius: CGFloat(50), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let smallShapeLayer = CAShapeLayer()
            smallShapeLayer.path = smallCirclePath.cgPath
            smallShapeLayer.fillColor = UIColor.clear.cgColor
            smallShapeLayer.strokeColor = UIColor.gray.cgColor
            smallShapeLayer.lineWidth = 2.0
            view.layer.addSublayer(smallShapeLayer)

            let myCountLabelString = "SET\u{000A} " + String(setButtonCount)
            let myCountLabelAttribute = [NSFontAttributeName: UIFont(name: "Verdana", size: 22)!]
            let myCountLabelAttrString = NSAttributedString(string: myCountLabelString, attributes: myCountLabelAttribute)
            setCountLabel.attributedText = myCountLabelAttrString
            setCountLabel.textColor = UIColor.darkGray
            setCountLabel.textAlignment = .center

            let alert = UIAlertController(title: "Alert", message: "When activated humidity levels will be kept at 80%. Do not store any cigars within your humidor while seasoning mode is activated.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

//    @IBAction func CigarLabsBackButtonTapped(_ sender: Any) {
//        self.performSegue(withIdentifier: "DetailView", sender: nil)
//    }

    @IBAction func bigCircleTapped(_ sender: Any) {
        // TODO: show the settings page
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
