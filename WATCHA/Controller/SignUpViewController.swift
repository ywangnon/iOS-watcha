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
    
    /// 로그인 버튼
    ///
    /// - Parameter sender: 누른 버튼
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let nickName = nickNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        guard isValidEmailAddress(email: email) else {
            print("email Check")
            
            let alertController = UIAlertController(title: "이메일 형식이 아닙니다.", message: "이메일을 정확히 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard isValidPassword(password) else {
            print("password Check")
            
            let alertController = UIAlertController(title: "비밀번호가 너무 짧습니다.", message: "비밀번호를 6자리 이상 입력해주세요", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
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
                    self.performSegue(withIdentifier: "goMain3", sender: nil)
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
    
    /// password 형태 검사
    ///
    /// - Parameter password: 입력된 패스워드
    /// - Returns: 지정된 형식의 패스워드 아님
    func isValidPassword(_ password: String) -> Bool {
        
        // 패스워드 정규식 : 6-20자 이내
        let passwordRegEx = "^(?=.*[a-zA-Z0-9]).{6,20}$"

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
