//
//  SignUpViewController.swift
//  WATCHA
//
//  Created by Hansub Yoo on 09/04/2018.
//  Copyright © 2018 Hansub Yoo. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - 검사 항목들
    
    // 체크박스 눌렸는지 Bool 값
    var isSelected: Bool = false
    
    /// 체크박스 버튼
    /// 누른 버튼의 isSelected 상태를 바꿔준다.
    /// - Parameter sender: 체크박스 버튼
    @IBAction func btn_box(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSelected =  !isSelected
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
    
    /// 로그인 버튼
    /// 이메일, 패스워드 형식과 체크박스가 눌렸는지 검사한 후 입력된 값을 보낸다.
    /// - Parameter sender: 로그인 버튼
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let nickName = nickNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        guard isValidEmailAddress(email: email) else {
            print("\n---------- [ Email Error ] ----------\n")
            
            let alertController = UIAlertController(title: "이메일 형식이 아닙니다.", message: "이메일을 정확히 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard isValidPassword(password) else {
            print("\n---------- [ Password Error ] ----------\n")
            
            let alertController = UIAlertController(title: "비밀번호가 너무 짧습니다.", message: "비밀번호를 6자리 이상 입력해주세요", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard isSelected else {
            print("\n---------- [ CheckBox Error ] ----------\n")
            
            let alertController = UIAlertController(title: "체크박스에 체크해야합니다.", message: "서비스 이용약관, 개인정보 취급 방침에 동의해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            
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
            .request(API.Auth.signUp, method: .post, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("\n---------- [ Login Success ] ----------\n")
                    
                    let userInfo = try! JSONDecoder().decode(login_User.self, from: value)
                    print(userInfo.token)
                    let token_String = userInfo.token
                    
                    let plist = UserDefaults.standard
                    plist.set(token_String, forKey: "user_Token")
                    plist.set(userInfo.user.pk, forKey: "#$id8461038765")
                    
                    self.performSegue(withIdentifier: "goMain3", sender: nil)
                    
                case .failure(let error):
                    print("\n---------- [ error ] ----------\n")
                    print(error.localizedDescription)
                    
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTextFieldSetting()
        createToolBar()
    }
    
    // MARK: - 초기 세팅
    
    // MARK: 레이어
    
    /// 레이어 커스텀
    ///
    /// - Parameter textfield: 커스텀하는 텍스트필드
    func layerSetting(of textfield: UITextField) {
        let width = CGFloat(2.0)
        
        let border = CALayer()
        border.borderColor = UIColor(red: 188/255, green: 187/255, blue: 193/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height-width, width: textfield.frame.size.width, height: textfield.frame.size.height)
        border.borderWidth = width
        
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
    }
    
    /// 커스텀 레이어 세팅하는 텍스트필드들
    func customTextFieldSetting() {
        layerSetting(of: nickNameTextField)
        layerSetting(of: emailTextField)
        layerSetting(of: passwordTextField)
    }
    
    // MARK: 키보드 Done 버튼
    
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.doneClicked))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        nickNameTextField.inputAccessoryView = toolbar
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    // MARK: 네비게이션 상태
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
