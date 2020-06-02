//
//  Next_registration.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 11/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import IQKeyboardManagerSwift
class Next_registration: UIViewController,UITextFieldDelegate,add_LocationCoordinates{

    
    var ref = Database.database().reference()
    
    @IBOutlet weak var loading: UIImageView!
    var loading_images:[UIImage] = []
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
    var userDetail = [String:String]()
    var userLogs:[String:String] = [:]
    @IBOutlet weak var middle_view: UIView!
    @IBOutlet weak var top_view: UIView!
    @IBOutlet weak var bottom_view: UIView!
    
   
    override func viewDidLoad() {
      
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside  = true
        userDetail = [:]
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        get_location.layer.cornerRadius = get_location.frame.height / 2
        get_location.backgroundColor = UIColor.darkGray
        get_location.layer.shadowColor = UIColor.red.cgColor
        get_location.layer.shadowRadius = 6
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
        middle_view.layer.cornerRadius = 45
        top_view.layer.cornerRadius = 30
        bottom_view.layer.cornerRadius = 30
        createImageArray(48, "loading")
        
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
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func add_data(){
        var email_id = email!.text!
        email_id.removeSubrange(email_id.index(email_id.endIndex, offsetBy: -10) ..<  email_id.endIndex)
        userDetail["Username"] = username!.text!
        userDetail["Phone_no"] = phone_no!.text!
        userDetail["Date_Of_Birth"] = date_of_birth!.text!
        userDetail["Location_Coordinates"] = location_coordinates.text!

      
        print(email_id)
        self.ref.child(email_id).setValue(userDetail)
        self.ref.child("\(email_id)_val").setValue([String:[Double]]())

        
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
            var trim_email_id = email!.text!
                  trim_email_id.removeSubrange(trim_email_id.index(trim_email_id.endIndex, offsetBy: -10) ..<  trim_email_id.endIndex)
            let usersDB = Database.database().reference().child("\(username!.text!)")
                var taken = false

                usersDB.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        taken = true
                        print("yes")
                    }
                    if !taken{
                                    
                                    Auth.auth().createUser(withEmail: key, password: value) { authResult, error in
                                            if let Error = error{
                                                print(Error)
                                            }
                                            else{
                                            
                                                    self.add_data()
                                                self.navigationController?.popToRootViewController(animated: true)
                                                }
                                        }
                    }
                             

                    
            
            
            
        
        
        })
        
    }
    }

    @IBAction func get_location(_ sender: Any) {
        
        locationManager.getLocation()
        animate(loading, loading_images)
    }
    func add_coordinates(_ coordinates:String){
        loading.stopAnimating()
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
