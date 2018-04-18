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
    /// 페이스북 기본 로그인 버튼
    /// - Parameters:
    ///   - loginButton: 정보를 보내는 sender
    ///   - result: 로그인 결과
    ///   - error: 로그인 오류(있을 경우)
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if error != nil {
//            print("\n---------- [ error ] ----------\n")
//            print(error.localizedDescription)
//        } else if result.isCancelled {
//            print("\n---------- [ User cancelled log in ] ----------\n")
//        } else {
//            print("\n---------- [ USER LOGGED IN ] ----------\n")
//            print(FBSDKAccessToken.current())
//            print("\n---------- [ Access Token ToString ] ----------\n")
//            print(FBSDKAccessToken.current().tokenString)
//
//            guard let fbToken = FBSDKAccessToken.current().tokenString else {
//                return
//            }
//
//            let params: Parameters = [
//                "access_token": fbToken
//            ]
//
//            Alamofire
//                .request(API.Auth.facebookSignIn, method: .post, parameters: params)
//                .validate()
//                .responseData { (response) in
//                    switch response.result {
//                    case .success(let value):
//                        print("\n---------- [ Login Success ] ----------\n")
//                        print("\(FBSDKAccessToken.current().tokenString)")
//                        user_Token = FBSDKAccessToken.current().tokenString
//                        print("\n---------- [ Value End ] ----------\n")
//                        self.performSegue(withIdentifier: "goMain", sender: nil)
//                    case .failure(let error):
//                        print("\n---------- [ data error ] ----------\n")
//                        print(error.localizedDescription)
//                    }
//            }
//        }
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
        
        // 페이스북 기본 로그인 버튼
        //        let btnFBLogin = FBSDKLoginButton(frame: CGRect(x: 40, y: 487, width: 295, height: 50))
        //        btnFBLogin.delegate = self
        //        btnFBLogin.setTitle("페북으로 시작하기", for: .normal)
        //        btnFBLogin.readPermissions = ["public_profile", "email"]
        //        self.view.addSubview(btnFBLogin)
        
        // 페이스북 커스텀 로그인 버튼
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 40, y: 487, width: 295, height: 50)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.layer.cornerRadius = 10
        myLoginButton.setTitle("페북으로 시작하기", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked ), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        
        if FBSDKAccessToken.current() != nil {
            print("\n---------- [ Tokken ] ----------\n")
            print("\(FBSDKAccessToken.current().tokenString)")
//            var token_String = ""
//
//            do {
//                let userInfo = try! JSONDecoder().decode(login_User.self, from: value)
//                print(userInfo)
//                token_String = userInfo.token
//                print("Completely Success")
//            } catch {
//                print(error.localizedDescription)
//            }
//
//            let plist = UserDefaults.standard
//            plist.set(token_String, forKey: "user_Token")
//            performSegue(withIdentifier: "goMain", sender: nil)
        } else {
            print("not logged in")
        }
    }
    
    /// navigation bar 숨김
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    /// 페이스북 커스텀 로그인 함수
    @objc func loginButtonClicked() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: [], from: self, handler: { (loginResult, error) in
            if error != nil {
                print("\n---------- [ error ] ----------\n")
                print(error!.localizedDescription)
            } else if loginResult!.isCancelled {
                print("\n---------- [ User cancelled log in ] ----------\n")
            } else {
                print("\n---------- [ USER LOGGED IN ] ----------\n")
                print(FBSDKAccessToken.current())
                print("\n---------- [ Access Token ToString ] ----------\n")
                print(FBSDKAccessToken.current().tokenString)
                
                guard let fbToken = FBSDKAccessToken.current().tokenString else {
                    return
                }
                
                let params: Parameters = [
                    "access_token": fbToken
                ]
                
                Alamofire
                    .request(API.Auth.facebookSignIn, method: .post, parameters: params)
                    .validate()
                    .responseData { (response) in
                        switch response.result {
                        case .success(let value):
                            print("\n---------- [ Login Success ] ----------\n")
                            
                            print("\(FBSDKAccessToken.current().tokenString)")
                            var token_String = ""
                            
                            do {
                                let userInfo = try! JSONDecoder().decode(login_User.self, from: value)
                                print(userInfo)
                                token_String = userInfo.token
                                print("Completely Success")
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            let plist = UserDefaults.standard
                            plist.set(token_String, forKey: "user_Token")
                            
                            print("\n---------- [ Value End ] ----------\n")
                            self.performSegue(withIdentifier: "goMain", sender: nil)
                            
                            
                        case .failure(let error):
                            print("\n---------- [ data error ] ----------\n")
                            print(error.localizedDescription)
                        }
                }
            }
        }
        )}
}

