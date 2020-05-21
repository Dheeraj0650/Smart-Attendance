//
//  Authentication.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 09/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit
import LocalAuthentication

class Authentication: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var preview: UIImageView!
    var touch_id_verification = false
    var face_id_verification = false
    var touch_id:[UIImage] = []
    var face_id:[UIImage] = []
    var verify:[UIImage] = []
    var background:[UIImage] = []
    var welcome:[UIImage] = []
     let imagePicker = UIImagePickerController()
    let face_Recognition = Detection()
    override func viewDidLoad() {
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
                touch_id_verification = true
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
