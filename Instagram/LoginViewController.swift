//
//  LoginViewController.swift
//  Instagram
//
//  Created by NICK on 1/31/18.
//  Copyright © 2018 NICK. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change up the following to hid3 pw txt
        //Create alert controllers
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
        }
        let wrongPasswordAlertController = UIAlertController(title: "Incorrect password", message: "The password you entered is incorrect. Please try again.", preferredStyle: .alert)
        let noUsernameAlertController = UIAlertController(title: "No username", message: "Please enter a username and try again.", preferredStyle: .alert)
        let invalidUsernameAlertController = UIAlertController(title: "Username is already taken", message: "The username you entered is already taken. Please enter a new one and try again.", preferredStyle: .alert)
        wrongPasswordAlertController.addAction(tryAgainAction)
        noUsernameAlertController.addAction(tryAgainAction)
        invalidUsernameAlertController.addAction(tryAgainAction)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignin(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("Successful sign in")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        
        
    }
    @IBAction func onSignup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("User successfully created!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                
                /*
                if error?.code == 202 {
                    print("")
                }*/
            }
        }
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
