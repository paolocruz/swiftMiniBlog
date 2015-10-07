//
//  SignInView.swift
//  MiniBlog
//
//  Created by Paolo Miguel Cruz on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol SignInViewDelegate{
    func signOutButtonPressed()
}

class SignInView: BaseView,GIDSignInUIDelegate{
    
    var delegate:SignInViewDelegate?
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func signOutButtonPressed(sender: AnyObject) {
         delegate?.signOutButtonPressed()
    }
}