
import UIKit
import Parse

class SentryModeViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    var currentHumidity: Int!
    var setButtonCount: Int! // TODO: initialize this to the number read from the DB

    var device: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let device = device {
            let caption = device["caption"] as? String

            captionLabel.text = caption

            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 350), radius: CGFloat(100), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.lineWidth = 3.0
            view.layer.addSublayer(shapeLayer)


            currentHumidity = 80
            //device["temperature"] as? Int
            setButtonCount = currentHumidity
            countLabel.text = String(currentHumidity)
            countLabel.textColor = UIColor.darkGray
            countLabel.textAlignment = .center
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
