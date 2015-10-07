//
//  SignInController.swift
//  MiniBlog
//
//  Created by Paolo Miguel Cruz on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
class SignInController: BaseController,GIDSignInUIDelegate{
    
    var signInView: SignInView?
    
    // MARK: Lifecycle method override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("SignInView")
        self.signInView = (self.view as! SignInView)
        GIDSignIn.sharedInstance().uiDelegate = self
        self.signInView!.myActivityIndicator.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUINotification",
            object: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "ToggleAuthUINotification",
            object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String!> =
                notification.userInfo as! Dictionary<String,String!>
                print(userInfo["statusText"])
                goToHome()
            }
        }
    }
    
    func goToHome()
    {
        self.performSegueWithIdentifier("goToHome", sender: self)
    }
    
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        self.signInView!.myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}