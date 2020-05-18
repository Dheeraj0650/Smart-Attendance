//
//  Authentication.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 09/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit

class Authentication: UIViewController {
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func verification(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            
             preview.loadGif(name: "face-id")
        }
        else if sender.selectedSegmentIndex == 2{
            preview.loadGif(name: "touch-id")
        }
        else{
          
            background.loadGif(name: "background")
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
