
import UIKit
import Parse

class Post: NSObject {

//    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }

    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    class func postUserImage(withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
//        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground { (success: Bool, error: Error?) in
            completion?(success, error)
        }
    }
    
}
