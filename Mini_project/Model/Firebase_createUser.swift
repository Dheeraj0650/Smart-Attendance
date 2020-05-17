//
//  Firebase_createUser.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 14/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import Foundation
import Firebase
class Create_User{
    
    func update(_ username:String , _ password:String){
                Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                            if let Error = error{
                                    print(Error)
                            }
                }
    }
    
}
