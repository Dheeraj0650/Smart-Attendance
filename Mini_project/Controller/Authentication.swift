//
//  Authentication.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 09/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import LocalAuthentication
import Firebase
import CoreLocation
import FirebaseDatabase
class Authentication: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{
    var ref = Database.database().reference()
    var destination = DetailsViewController()
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var bottom_view: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var attendance_view: UIImageView!
    @IBOutlet weak var preview_view: UIView!
    @IBOutlet weak var middle_imageView: UIImageView!
    @IBOutlet weak var middle_view: UIView!
    @IBOutlet weak var preview: UIImageView!
    
    var email:String?
    var locationManager = CLLocationManager()
    var touch_id_verification = false
    var face_id_verification = false
    var touch_id:[UIImage] = []
    var face_id:[UIImage] = []
    var verify:[UIImage] = []
    var background:[UIImage] = []
    var welcome:[UIImage] = []
     let imagePicker = UIImagePickerController()
    let face_Recognition = Detection()
    var distance = CalculateDistance()
     var log_dic = [String:[Double]]()
    override func viewDidLoad() {
        log_dic = [:]
        face_Recognition.delegate = self
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        super.viewDidLoad()
        message.text! = ""
        createImageArray(163, "face-id")
        createImageArray(155, "touch-id")
        createImageArray(120, "verify")
        createImageArray(128, "background")
        createImageArray(107, "welcome")
        middle_view.layer.cornerRadius = 30
        bottom_view.layer.cornerRadius = 40
        middle_imageView.layer.cornerRadius = 30
        preview_view.layer.cornerRadius = 30
        attendance_view.layer.cornerRadius = 30
        var email_id = email!
        email_id.removeSubrange(email_id.index(email_id.endIndex, offsetBy: -10) ..<  email_id.endIndex)
        let usersDB = Database.database().reference().child("\(email_id)_val")
        usersDB.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                        let dic = snapshot.value as! NSDictionary
                        for i in dic{
                            self.log_dic[i.key as! String] = i.value as? [Double]
                        }
            }
        })
        animate(preview, welcome)
        // Do any additional setup after loading the view.
    }
    
    func delivered_message(_ message: String) {
        self.message.text! = message
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            guard let ciimage = CIImage(image: image) else {
                self.message.text! = "Try again"
                return
            }
            face_Recognition.detect(ciimage)
        }
        if face_id_verification{
            animate(preview, face_id)
        }
        else{
            message.text! = "try again"
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    

    
    func createImageArray(_ total:Int,_ imagePrefix:String){
        for i in 0..<total{
            let imageName = "\(imagePrefix)-\(i)"
            let image = UIImage(named: imageName, in: Bundle(for: Authentication.self), with: nil)!
            if imagePrefix == "touch-id"{
                touch_id.append(image)
            }
            else if imagePrefix == "verify"{
                verify.append(image)
            }
            else if imagePrefix == "face-id"{
               
                face_id.append(image)
            }
            else if imagePrefix == "background"{
                background.append(image)
            }
            else{
                welcome.append(image)
            }

        }
    }
    
    func animate(_ imageView:UIImageView,_ images:[UIImage]){
        imageView.animationImages = images
        imageView.animationDuration = 5
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    
    
    @IBAction func verification(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            preview.stopAnimating()
            message.text! = ""
            present(imagePicker, animated: true, completion: nil)
            print(face_id_verification)
         
        }
        else if sender.selectedSegmentIndex == 2{
            preview.stopAnimating()
            message.text! = ""
            if touch_id_verification{
                message.text! = "Fingerprint already verified"
            }
            else{
                authenticateUser()
                
            }
        }
        else{
            preview.stopAnimating()
            message.text! = ""
            if self.face_id_verification && self.touch_id_verification {
                self.animate(self.preview, self.verify)
            }
            else if !self.face_id_verification && !self.touch_id_verification {
                self.message.text! = "Face and Fingerprint is not verified"
            }
            else if !self.face_id_verification {
                self.message.text! = "Face is not verified"
            }
            else{
                self.message.text! = "Fingerprint is not verified"
            }
        }
        
    }
   
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.animate(self.preview,self.touch_id)
                        self.message.text! = ""
                        self.touch_id_verification = true
                    }
                    else{
                        self.message.text! = "Invalid Touch ID"
                    }
                }
            }
        } else {
            self.message.text! = "Lock the phone and Unlock using passcode"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            let firebaseAuth = Auth.auth()
           do {
             try firebaseAuth.signOut()
           } catch let signOutError as NSError {
             print ("Error signing out: %@", signOutError)
           }
             
        }
    }
    @IBAction func mark_attendance(_ sender: Any) {

        if (touch_id_verification && face_id_verification){

            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()

        }
        else{
            
            message.text! = "Verification Failed"
            
        }
        
         
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat1 = 0.0
            let lon1 = 0.0
            let coordinate0 = CLLocation(latitude: Double(round(1000000*lat1)/1000000), longitude: Double(round(1000000*lon1)/1000000))
            let d = coordinate0.distance(from: location)
            if d.rounded(.towardZero) < 30 {
                
                var email_id = email!
                email_id.removeSubrange(email_id.index(email_id.endIndex, offsetBy: -10) ..<  email_id.endIndex)
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                self.log_dic["\(hour):\(minutes)"] = [Double(location.coordinate.latitude),Double(location.coordinate.longitude)]
                self.ref.child("\(email_id)_val").setValue(self.log_dic)
                            
                message.text! = "your attendance has been recorded"
                segmentedControl.setImage(UIImage(systemName: "lock.open.fill" ), forSegmentAt: 1)
                
                
                
            }
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     print("error")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailsViewController {
            var email_id = email!
            email_id.removeSubrange(email_id.index(email_id.endIndex, offsetBy: -10) ..<  email_id.endIndex)
            destinationVC.detail_log_dic = log_dic
            destinationVC.email = "\(email_id)_val"
            
        
            
        }
    }
    @IBAction func Details(_ sender: Any) {
        performSegue(withIdentifier: "AuthenticationToDetailsViewController", sender: nil)
    }
    
}
