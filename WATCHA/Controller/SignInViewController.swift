//
//  SignInViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire


class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnFBLogin = FBSDKLoginButton(frame: CGRect(x: 40, y: 124, width: 295, height: 50))
        view.addSubview(btnFBLogin)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
