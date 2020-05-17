//
//  ViewController.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 08/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        email.delegate = self
        email.text! = ""
        email.placeholder! = "username"
        
        password.delegate = self
        password.text! = ""
        password.placeholder! = "password"
        
        login_button.backgroundColor = UIColor.darkGray
        login_button.layer.cornerRadius = login_button.frame.height / 2
        login_button.setTitleColor(UIColor.white,for: .normal)
        login_button.layer.shadowColor = UIColor.red.cgColor
        login_button.layer.shadowRadius = 6
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func login(_ sender: Any) {
        if let key  = email.text,let value = password.text{
                
            Auth.auth().signIn(withEmail: key, password: value) { authResult, error in
                    
                if let Error = error{
                    self.email.text! = ""
                    self.password.text! = ""
                    self.email.placeholder! = Error.localizedDescription
                    self.password.placeholder! = Error.localizedDescription
                    
                }
                else{
                    self.performSegue(withIdentifier: "LoginToAuthentication", sender: nil)
                }
                }
                    
        }
        
        
    }
    

    @IBAction func signup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LoginToSignup", sender:self)
    }
    

}

