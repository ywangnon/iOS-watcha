//
//  ViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire

class WelcomeViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    /// button을 사용하여 로그인 할 때 delegate에게 보냄
    ///
    /// - Parameters:
    ///   - loginButton: 정보를 보내는 sender
    ///   - result: 로그인 결과
    ///   - error: 로그인 오류(있을 경우)
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("\n---------- [ error ] ----------\n")
            print(error.localizedDescription)
        } else if result.isCancelled {
            print("\n---------- [ User cancelled log in ] ----------\n")
        } else {
            print("\n---------- [ USER LOGGED IN ] ----------\n")
            print(FBSDKAccessToken.current())
            print("\n---------- [ Access Token ToString ] ----------\n")
            print(FBSDKAccessToken.current().tokenString)
            
            let params: Parameters = [
                "access_token": FBSDKAccessToken.current()
            ]
            
            Alamofire
                .request(API.Auth.facebookSignIn, method: .post, parameters: params)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let Value):
                        print("\n---------- [ Login Success ] ----------\n")
                        print(Value)
                        print("\n---------- [ Value End ] ----------\n")
                    case .failure(let error):
                        print("\n---------- [ login success but error ] ----------\n")
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    /// button을 사용하여 logout 한 경우 delegate에게 보냄.
    ///
    /// - Parameter loginButton: 클릭한 버튼
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\n---------- [ logged out ] ----------\n")
    }
    
    
   override func viewDidLoad() {
      super.viewDidLoad()
    
    centerImg.image = #imageLiteral(resourceName: "watcha")
    
    let imgs = [#imageLiteral(resourceName: "book"),#imageLiteral(resourceName: "cinema"),#imageLiteral(resourceName: "film"),#imageLiteral(resourceName: "lake"),#imageLiteral(resourceName: "sky")]
    backgroundImg.animationImages = imgs
    backgroundImg.animationDuration = 10
    backgroundImg.startAnimating()
    
    let btnFBLogin = FBSDKLoginButton(frame: CGRect(x: 40, y: 487, width: 295, height: 50))
    btnFBLogin.delegate = self
    btnFBLogin.readPermissions = ["public_profile", "email"]
    
    self.view.addSubview(btnFBLogin)
    
    if FBSDKAccessToken.current() != nil {
        print("\n---------- [ Tokken ] ----------\n")
        print("LOGGED IN, \(FBSDKAccessToken.current())")
    } else {
        print("not logged in")
    }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

