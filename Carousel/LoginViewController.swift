//
//  LoginViewController.swift
//  Carousel
//
//  Created by Jason Cashdollar on 10/30/15.
//  Copyright © 2015 Jason Cashdollar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var loginNavBar: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var fieldParentInitialY: CGFloat!
    var buttonParentInitialY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 320, height: 600)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        fieldParentInitialY = fieldParentView.frame.origin.y
        buttonParentInitialY = buttonParentView.frame.origin.y
        
        activityIndicator.alpha = 0
    }
    
    // The main view is about to appear...
    override func viewWillAppear(animated: Bool) {
        // Set initial transform values 20% of original size
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        // Apply the transform properties of the views
        loginNavBar.transform = transform
        fieldParentView.transform = transform
        // Set the alpha properties of the views to transparent
        loginNavBar.alpha = 0
        fieldParentView.alpha = 0
    }
    
    // The main view appeared...
    override func viewDidAppear(animated: Bool) {
        //Animate the code within over 0.3 seconds...
        UIView.animateWithDuration(0.3) { () -> Void in
            // Return the views transform properties to their default states.
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.loginNavBar.transform = CGAffineTransformIdentity
            // Set the alpha properties of the views to fully opaque
            self.fieldParentView.alpha = 1
            self.loginNavBar.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func keyboardWillShow(notification: NSNotification!) {
        
        buttonParentView.transform = CGAffineTransformMakeTranslation(0, -180)
        fieldParentView.transform = CGAffineTransformMakeTranslation(0, -70)
        
        let maxContentOffsetY = scrollView.contentSize.height - scrollView.frame.size.height
        
        scrollView.contentOffset.y = maxContentOffsetY
        
        scrollView.scrollEnabled = true
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        self.fieldParentView.frame.origin = CGPoint(x: self.fieldParentView.frame.origin.x, y: self.fieldParentInitialY)
        
        self.buttonParentView.frame.origin = CGPoint(x: self.buttonParentView.frame.origin.x, y: self.buttonParentInitialY)
    }
    
    @IBAction func didTapBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        
        if emailField.text == "email" && passwordField.text == "password" {
            // login
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
            delay(2){
                self.performSegueWithIdentifier("tutorialSegue", sender: self)
            }
        } else if emailField.text!.isEmpty || passwordField.text!.isEmpty{
            // popup alert
            let alertController = UIAlertController(title: "Email Required", message: "Please enter your email address", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            
        } else {
            // incorrect email pw
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
            delay(2){
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
                
                let alertBadPasswordController = UIAlertController(title: "Please try again", message: "The email or password are not correct", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                alertBadPasswordController.addAction(OKAction)
                self.presentViewController(alertBadPasswordController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
        

    }


}
