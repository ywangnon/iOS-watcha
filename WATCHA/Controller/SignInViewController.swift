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
                case .failure(let error):
                    print("\n---------- [ data error ] ----------\n")
                    print(error.localizedDescription)
                }
        }
    }
    
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
    
    @objc func clearTextField(_ sender: UIButton, _ textField: UITextField) {
        textField.text = nil
    }
}
