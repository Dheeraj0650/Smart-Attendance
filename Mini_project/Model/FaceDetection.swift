//
//  FaceDetection.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 21/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import Foundation
import CoreML
import UIKit
import Vision
class Detection{
    
    var delegate:Authentication?
    
    func detect(_ image:CIImage){
        
        
        guard let model = try? VNCoreMLModel(for:Inceptionv3().model) else{
         
            return
        }
        let request = VNCoreMLRequest(model: model) { (Request,
            Error) in
            
            guard let results = Request.results as? [VNClassificationObservation] else{
              
                return
            }
            print(results)
            if let result = results.first {
                print(result.identifier.contains("mouse"))
                if result.identifier.contains("mouse"){
                    self.delegate!.face_id_verification = true
                }
                else{
                    self.delegate!.face_id_verification = false
                }
            }
      
        }
        
        let handler = VNImageRequestHandler(ciImage:image)
        do{
            try handler.perform([request])
            self.delegate!.face_id_verification = true
        }
        catch{
            
        }
    }
    
    
    
    
    
}
