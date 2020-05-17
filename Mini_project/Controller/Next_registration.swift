//
//  Next_registration.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 11/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import Firebase
class Next_registration: UIViewController,UITextFieldDelegate,add_LocationCoordinates{

    

    @IBOutlet weak var get_location: UIButton!
    @IBOutlet weak var Signup: UIButton!
    var username:UITextField?
    var email:UITextField?
    var phone_no:UITextField?
    var date_of_birth:UITextField?
    
    @IBOutlet weak var location_coordinates: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var re_enter_password: UITextField!
    var locationManager = Location_coordinates()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        get_location.layer.cornerRadius = get_location.frame.height / 2
        location_coordinates.delegate = self
        location_coordinates.text!=""
        location_coordinates.placeholder! = "location coordinates"
        
        password.delegate = self
        password.text! = ""
        password.placeholder! = "password"
        
        re_enter_password.delegate = self
        re_enter_password.placeholder! = "re-enter password"
        
        
        Signup.backgroundColor = UIColor.darkGray
        Signup.layer.cornerRadius = Signup.frame.height / 2
        Signup.setTitleColor(UIColor.white,for: .normal)
        Signup.layer.shadowColor = UIColor.red.cgColor
        Signup.layer.shadowRadius = 6
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    

    @IBAction func signup(_ sender: Any) {
        if let a = password.text,let b = re_enter_password.text{
            if a != b{
                password.placeholder! = "No Match"
                return
            }
        
        }
        else{
            return
        }
        if let key = email?.text,let value = password.text{
            Auth.auth().createUser(withEmail: key, password: value) { authResult, error in
                if let Error = error{
                    print(Error)
                }
                else{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        
        }
        
    }

    @IBAction func get_location(_ sender: Any) {
        locationManager.getLocation()
    }
    func add_coordinates(_ coordinates:String){
        location_coordinates.text! = coordinates
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
