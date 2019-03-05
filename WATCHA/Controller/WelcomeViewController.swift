//
//  ViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Yoo Hansub. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire


class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundIMGSetting()
        customFacebookLoginSetting()
        facebookCurrentLoginCheck()
    }
    
    // MARK: - 초기 세팅
    // 백그라운드의 회전되는 이미지
    func backgroundIMGSetting() {
        let imgs = [#imageLiteral(resourceName: "book"),#imageLiteral(resourceName: "cinema"),#imageLiteral(resourceName: "film"),#imageLiteral(resourceName: "lake"),#imageLiteral(resourceName: "sky")]
        backgroundImg.animationImages = imgs
        backgroundImg.animationDuration = 10
        backgroundImg.startAnimating()
    }
    
    // 페이스북 커스텀 로그인 버튼
    func customFacebookLoginSetting() {
        
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 40, y: 450, width: 334, height: 50)
        myLoginButton.backgroundColor = UIColor(red: 66/255, green: 103/255, blue: 178/255, alpha: 1.0)
        myLoginButton.layer.cornerRadius = 10
        myLoginButton.setTitle("페북으로 시작하기", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked ), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
    }
    
    // 최근 로그인된 facebook 토큰 값
    func facebookCurrentLoginCheck() {
        if FBSDKAccessToken.current() != nil {
            print("\n---------- [ Tokken ] ----------\n")
            print("\(FBSDKAccessToken.current().tokenString)")
        } else {
            print("not logged in")
        }
    }
    
    /// navigation bar 숨김
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - 페이스북 로그인 관련 함수
    /// 페이스북 커스텀 로그인 함수
    @objc func loginButtonClicked() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: [], from: self, handler: { (loginResult, error) in
            if error != nil {   // 에러
                print("\n---------- [ error ] ----------\n")
                print(error!.localizedDescription)
            } else if loginResult!.isCancelled {    // 취소 처리
                print("\n---------- [ User cancelled log in ] ----------\n")
            } else {    // 로그인 성공
                print("\n---------- [ USER LOGGED IN ] ----------\n")
                print(FBSDKAccessToken.current().tokenString)
                
                guard let fbToken = FBSDKAccessToken.current().tokenString else { return }
                
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
                            
                            print("\(FBSDKAccessToken.current().tokenString)")
                            
                            // 데이터 디코더
                            let userInfo = try! JSONDecoder().decode(login_User.self, from: value)
                            let token_String = userInfo.token
                            print("Completely Success")
                            
                            // 토큰 저장
                            UserDefaults.standard.set(token_String, forKey: "user_Token")
                            
                            self.performSegue(withIdentifier: "goMain", sender: nil)
                        case .failure(let error):
                            print("\n---------- [ data error ] ----------\n")
                            print(error.localizedDescription)
                        }
                }
            }
        })
    }
    
    /// button을 사용하여 logout 한 경우 delegate에게 보냄.
    ///
    /// - Parameter loginButton: 클릭한 버튼
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\n---------- [ logged out ] ----------\n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
