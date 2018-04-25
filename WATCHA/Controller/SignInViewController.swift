//
//  SignInViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Yoo Hansub. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire


class SignInViewController: UIViewController {
    
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
            .request(API.Auth.emailLogin, method: .post, parameters: params)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    print("\n---------- [ Login Success ] ----------\n")
                    print(value)
                    var token_String = ""
                    
                    let userInfo = try! JSONDecoder().decode(login_User.self, from: value)
                    print(userInfo)
                    print(userInfo.token)
                    token_String = userInfo.token
                    print("Completely Success")
                    
                    let plist = UserDefaults.standard
                    plist.set(token_String, forKey: "user_Token")
                    plist.set(userInfo.user.pk, forKey: "#$id8461038765")
                    print("\n---------- [ user_Token ] ----------\n")
                    print(plist.string(forKey: "user_Token")!)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = CGFloat(2.0)

        // 커스텀 텍스트필드 리팩토링 필요
        let border = CALayer()
        border.borderColor = UIColor(red: 188/255, green: 187/255, blue: 193/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height-width, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height)
        border.borderWidth = width
        
        emailTextField.layer.addSublayer(border)
        emailTextField.layer.masksToBounds = true
        
        let border2 = CALayer()
        border2.borderColor = UIColor(red: 188/255, green: 187/255, blue: 193/255, alpha: 1.0).cgColor
        border2.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-width, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        border2.borderWidth = width
        
        passwordTextField.layer.addSublayer(border2)
        passwordTextField.layer.masksToBounds = true
        
        
        // 페이스북 커스텀 로그인 버튼
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 40, y: 467, width: 334, height: 50)
        myLoginButton.backgroundColor = UIColor(red: 66/255, green: 103/255, blue: 178/255, alpha: 1.0)
        myLoginButton.layer.cornerRadius = 10
        myLoginButton.setTitle("페북으로 시작하기", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked ), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        createToolBar()
    }
    
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.doneClicked))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
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
                    .request(API.Auth.facebookLogin, method: .post, parameters: params)
                    .validate()
                    .responseData { (response) in
                        switch response.result {
                        case .success(let value):
                            print("\n---------- [ Login Success ] ----------\n")
                            
                            let userInfo = try! JSONDecoder().decode(user.self, from: value)
                            print(userInfo)
                            print("Completely Success")
                            
                            print("\(FBSDKAccessToken.current().tokenString)")
                            let token_String = FBSDKAccessToken.current().tokenString
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
