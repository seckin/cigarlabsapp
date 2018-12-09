
import UIKit
import Parse
import ParseLiveQuery
import Photos
import SwiftEntryKit

private enum ThumbDesc: String {
    case bottomToast = "ic_bottom_toast"
    case bottomFloat = "ic_bottom_float"
    case topToast = "ic_top_toast"
    case topFloat = "ic_top_float"
    case statusBarNote = "ic_sb_note"
    case topNote = "ic_top_note"
    case bottomPopup = "ic_bottom_popup"
}

typealias MainFont = Font.HelveticaNeue

enum Font {
    enum HelveticaNeue: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "UltraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case boldItalic = "BoldItalic"

        func with(size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-\(rawValue)", size: size)!
        }
    }
}

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    // initialize the following variables
    var captionPost = ""

    private func showPopupMessage(attributes: EKAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage? = nil) {

        var themeImage: EKPopUpMessage.ThemeImage?

        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }

        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 24), color: titleColor, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: MainFont.light.with(size: 16), color: descriptionColor, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: MainFont.bold.with(size: 16), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor, highlightedBackgroundColor: buttonTitleColor.withAlphaComponent(0.05))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }

        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var attributes: EKAttributes

        attributes = EKAttributes.centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [UIColor(red:1.00, green:0.98, blue:0.84, alpha:1.0), UIColor(red:0.70, green:0.04, blue:0.17, alpha:1.0)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color: UIColor(white: 50.0/255.0, alpha: 0.3))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                             scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .offset(value: 20), height: .intrinsic)//.init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBar = .dark
//        var descriptionString = "Centeralized floating popup with dimmed background"
//        var descriptionThumb = ThumbDesc.bottomPopup.rawValue
//        var description = SwiftEntryKit.init(with: attributes, title: "Pop Up II", description: descriptionString, thumb: descriptionThumb)
//        presets.append(description)

        let image = UIImage(named: "insta_camera_btn")!
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a pop up with important content"
        showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0), buttonBackgroundColor: .white, image: image)

    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func onShare(_ sender: Any) {
        //  MBProgressHUD.showAdded(to: self.view, animated: true)
        print("onShare was called")
        captionPost = captionField.text ?? ""
        Post.postUserImage(withCaption: captionPost) { (status: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Post successful")
                //       MBProgressHUD.hide(for: self.view, animated: true)
                //Goes back to feed after posting
                self.tabBarController?.selectedIndex = 0
                //Reset photo selected
//                self.imagePost = UIImage(named: "imageName")
                self.captionPost = ""
            }
        }

        // segue to home vc
        self.performSegue(withIdentifier: "AuthenticatedViewController", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
