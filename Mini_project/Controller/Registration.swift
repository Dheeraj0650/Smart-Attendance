//
//  Registration.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 09/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
class Registration: UIViewController,UITextFieldDelegate{
    var new_user = Create_User()

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var gmail: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var phone_no: UITextField!
    @IBOutlet weak var background: UIView!
    

    @IBOutlet weak var another_background: UIView!
    @IBOutlet weak var date_of_birth: UITextField!
    let validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside  = true
        username.delegate = self
        username.text! = ""
        username.placeholder! = "username"
        
        gmail.delegate = self
        gmail.text! = ""
        gmail.placeholder! = "gmail"
        
        phone_no.delegate = self
        phone_no.text! = ""
        phone_no.placeholder! = "phone no(123-456-7890)"
        
        date_of_birth.delegate = self
        date_of_birth.text! = ""
        date_of_birth.placeholder! = "date(dd:mm:yyyy)"
   
        
        signup.backgroundColor = UIColor.darkGray
               signup.layer.cornerRadius = signup.frame.height / 2
               signup.setTitleColor(UIColor.white,for: .normal)
               signup.layer.shadowColor = UIColor.red.cgColor
               signup.layer.shadowRadius = 6
        background.layer.cornerRadius = 45
        background.layer.shadowRadius = 20
        background.layer.shadowColor = UIColor.red.cgColor
        another_background.layer.cornerRadius = 30
       
        // Do any additional setup after loading the view.
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.endEditing(true)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? Next_registration
        destinationVC?.username = username
        destinationVC?.date_of_birth = date_of_birth
        destinationVC?.email = gmail
        destinationVC?.phone_no = phone_no
    }
    
    @IBAction func next(_ sender: Any) {
        
        var conformation:[UITextField:Bool] = [username:true,gmail:true,phone_no:true,date_of_birth:true]
        
        if let email = gmail.text{
            if !validation.isValidEmailAddress(emailAddressString: email){
                gmail.placeholder! = "Invalid Email Id"
                conformation[gmail] = false
            }
        }
        if let date = date_of_birth.text{

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd:MM:yyyy"

            if dateFormatter.date(from: date) != nil {
                
            } else {
                date_of_birth.placeholder! = "Invalid Date Format"
                conformation[date_of_birth] = false
            }
        }
        if let name = username.text{
            if !validation.isValidUsername(Input: name){
                username.placeholder! = "Invalid Username"
                conformation[username] = false
            }
            
        }
        
        if let phone_no = phone_no.text{
            if !validation.isValidPhone_no(value: phone_no){
                self.phone_no.placeholder! = "Invalid Phone Number"
                conformation[self.phone_no] = false
            }
            
        }
        var move_forward = "Yes"
        for (key,value) in conformation{
            if value == false{
                key.text! = ""
                key.placeholder! = "invalid"
                move_forward = "No"
            }
            
        }
        if move_forward == "No"{
            return
        }
        
       
        self.performSegue(withIdentifier: "SignupToNext", sender: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print ( signOutError.localizedDescription)
                }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
               username.text! = ""
               username.placeholder! = "username"
               
           
               gmail.text! = ""
               gmail.placeholder! = "gmail"
               
        
               phone_no.text! = ""
               phone_no.placeholder! = "phone no(123-456-7890)"
               

               date_of_birth.text! = ""
               date_of_birth.placeholder! = "date(dd:mm:yyyy)"
               
    }

}
