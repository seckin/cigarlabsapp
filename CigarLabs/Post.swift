
import UIKit
import Parse

class Device: NSObject {

    @NSManaged var author: PFUser
    @NSManaged var caption: String
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Device"
    }

    /**
     * Other methods
     */
    
    /**
     Method to add a user device to Parse

     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    class func postUserImage(withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let device = PFObject(className: "Device")
        
        // Add relevant fields to the object
        device["author"] = PFUser.current() // Pointer column type that points to PFUser
        device["caption"] = caption
        device["humidity"] = 70
        
        // Save object (following function will save the object in Parse asynchronously)
        device.saveInBackground { (success: Bool, error: Error?) in
            completion?(success, error)
        }
    }
    
}
