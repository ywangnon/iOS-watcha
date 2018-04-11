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
        let password = passwordTextField.text else {
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
    
    func passwordCheck(_ password: String) -> Bool {
        
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
