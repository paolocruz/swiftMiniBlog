//
//  SignInView.swift
//  MiniBlog
//
//  Created by Paolo Miguel Cruz on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit

class SignInView: BaseView,GIDSignInUIDelegate{
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
}