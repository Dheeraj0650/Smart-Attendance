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
    @IBOutlet weak var loading: UIImageView!
    @IBOutlet weak var Background: UIView!
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login_button: UIButton!
    var loading_images:[UIImage]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        email.delegate = self
        email.text! = ""
        email.placeholder! = "Email"
        
        password.delegate = self
        password.text! = ""
        password.placeholder! = "Password"
        
      
       
        login_button.backgroundColor = UIColor.darkGray
        login_button.layer.cornerRadius = login_button.frame.height / 2
        login_button.setTitleColor(UIColor.white,for: .normal)
        login_button.layer.shadowColor = UIColor.red.cgColor
        login_button.layer.shadowRadius = 6
        Background.layer.cornerRadius = 50
        
        
     
        signup.layer.cornerRadius = signup.frame.height/2
        signup.layer.shadowRadius = 6
        signup.layer.shadowColor = UIColor.black.cgColor
        createImageArray(65, "login_loading")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func login(_ sender: Any) {
        if let key  = email.text,let value = password.text{
            animate(loading, loading_images)
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
                self.loading.stopAnimating()
                }
                    
        }
        
        
    }
    func createImageArray(_ total:Int,_ imagePrefix:String){
           for i in 0..<total{
               let imageName = "\(imagePrefix)-\(i)"
               let image = UIImage(named: imageName)!
               loading_images.append(image)
           }
    }
    
    func animate(_ imageView:UIImageView,_ images:[UIImage]){
         imageView.animationImages = images
         imageView.animationDuration = 1
         imageView.startAnimating()
     }
    
    

    @IBAction func signup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LoginToSignup", sender:self)
    }
    override func viewWillAppear(_ animated: Bool) {
        email.text! = ""
        email.placeholder! = "Email"
        password.text! = ""
        password.placeholder! = "Password"
        
    }

}

