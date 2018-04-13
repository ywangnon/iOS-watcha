//
//  SignUpViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let nickName = nickNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        guard isValidEmailAddress(email: email) else {
            print("email Check")
            return
        }
        
        guard isValidPassword(password) else {
            print("password Check")
            return
        }
        
        let params: Parameters = [
            "email": email,
            "nickname": nickName,
            "password": password
        ]
        
        Alamofire
            .request(API.Auth.emailSignUp, method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let Value):
                    print("\n---------- [ Login Success ] ----------\n")
                    print(Value)
                    print("\n---------- [ Value End ] ----------\n")
                case .failure(let error):
                    print("\n---------- [ error ] ----------\n")
                    print(error.localizedDescription)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidPassword(_ password: String) -> Bool {
        
        let passwordRegEx = "/^(?=.*[a-zA-Z])((?=.*\\d)|(?=.*\\W)).{6,20}$/"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        return passwordTest.evaluate(with: password)
    }
    
    
    /// email 형태 검사
    ///
    /// - Parameter email: 입력된 email
    /// - Returns: true는 이메일 형식, false는 이메일 형식 아님
    func isValidEmailAddress(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    
    /// 이 창에서 navigation bar 띄움
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        // 버튼 title setting
        let backButton = UIBarButtonItem()
        backButton.title = "첫화면"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    /// 메인 창에서 nvigation bar 숨김
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
}
