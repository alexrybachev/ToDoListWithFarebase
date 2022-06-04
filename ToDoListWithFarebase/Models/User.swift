//
//  User.swift
//  ToDoListWithFarebase
//
//  Created by Aleksandr Rybachev on 04.06.2022.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserModel {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
