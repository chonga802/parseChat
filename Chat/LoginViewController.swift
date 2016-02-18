//
//  LoginViewController.swift
//  Chat
//
//  Created by Christine Hong on 2/17/16.
//  Copyright © 2016 christinehong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                PFUser.logInWithUsernameInBackground(email, password: password) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Do stuff after successful login.
                        self.performSegueWithIdentifier("LoginSegue", sender: self)
                    } else {
                        self.showAlert("Login Error", message: "Failed to login!")
                    }
                }
            }
        }
    }

    @IBAction func onSignup(sender: AnyObject) {
        let user = PFUser()
        user.username = emailTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let _ = error {
                self.showAlert("Signup Error", message: "Failed to signup!")
            } else {
                print("Signup")
                self.performSegueWithIdentifier("LoginSegue", sender: self)
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: "Signup Error", message: "Failed to signup!", preferredStyle: .Alert)
        
        let alertAction = UIAlertAction(title: "OK", style:  .Default) { (action) in
            print("OK!")
        }
        
        alertController.addAction(alertAction)
        
        presentViewController(alertController, animated: true) {
            print("Done showing alert")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
