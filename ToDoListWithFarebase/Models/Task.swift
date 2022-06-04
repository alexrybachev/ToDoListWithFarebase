//
//  Task.swift
//  ToDoListWithFarebase
//
//  Created by Aleksandr Rybachev on 04.06.2022.
//

import Foundation
import Firebase

struct TaskModel {
    let title: String
    let userId: String
    let ref: DatabaseReference? // FIRDatabaseReference
    var completed = false
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) { // FIRDataSnapshot
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
