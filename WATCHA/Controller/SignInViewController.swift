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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        
        let params: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire
            .request(API.Auth.emailSignIn, method: .post, parameters: params)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    print("\n---------- [ Login Success ] ----------\n")
                    print(value)
                    self.performSegue(withIdentifier: "goMain2", sender: nil)
                case .failure(let error):
                    print("\n---------- [ data error ] ----------\n")
                    print(error.localizedDescription)
                    
                    if error.localizedDescription == "Response status code was unacceptable: 400." {
                        
                        // 한번밖에 안됨, 리팩토링 필요
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 1, options: [], animations: {
                            print("animation")
                            self.view.frame.origin.x = 5
                            self.view.layoutIfNeeded()
                            self.view.frame.origin.x = -5
                            self.view.setNeedsLayout()
                        }, completion: { (bool) in
                            print("alert")
                            let alertController = UIAlertController(title: "아이디 혹은 비밀번호를 잘못 입력하였습니다.", message: "다시 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        })
                    }
                }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let btnFBLogin = FBSDKLoginButton(frame: CGRect(x: 40, y: 124, width: 295, height: 50))
        //        view.addSubview(btnFBLogin)
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 이 창에서 navigation bar 띄움
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        // 버튼 title setting
        let backButton = UIBarButtonItem()
        backButton.title = "첫화면"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    /// 메인 창에서 navigation bar 숨김
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
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
                            let token_String = FBSDKAccessToken.current().tokenString
                            let plist = UserDefaults.standard
                            
                            plist.set(token_String, forKey: "user_Token")
//                            user_Token = FBSDKAccessToken.current().tokenString
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
