//
//  Skill.swift
//  SERV Resilliency
//
//  Created by Todd Crane on 6/9/15.
//  Copyright © 2015 Todd Crane. All rights reserved.
//

import Foundation
import CloudKit

class Skill : NSObject {
    var record : CKRecord!
    weak var database : CKDatabase!
    
    var name : String!
    var body : String!
    var id : CKRecordID
    var approved : Bool {
    get {
        return record.objectForKey("skillApproved") as! Bool
        }
    }
    
    init(record: CKRecord, database: CKDatabase) {
        print("loading")
        self.record = record
        self.database = database
        self.id = self.record.recordID
        self.name = record.objectForKey("skillName") as! String
    }

    var title : String? {
        get {
            return name
        }
    }
}