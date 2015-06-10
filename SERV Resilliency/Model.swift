//
//  Model.swift
//  SERV Resilliency
//
//  Created by Todd Crane on 6/9/15.
//  Copyright © 2015 Todd Crane. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

let EstablishmentType = "Establishment"
let NoteType = "Note"

protocol ModelDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}


@objc class Model {
    class func sharedInstance() -> Model {
        return modelSingletonGlobal
    }
    
    var delegate : ModelDelegate?
    
    var items = [Skill]()
    //let userInfo : UserInfo
    
    let container : CKContainer
    let publicDB : CKDatabase
    //let privateDB : CKDatabase
    
    init() {
        container = CKContainer.defaultContainer() //1
        publicDB = container.publicCloudDatabase //2
        //privateDB = container.privateCloudDatabase //3
        
        //userInfo = UserInfo(container: container)
    }
    func refresh() {
        let approvedPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "resiliencySkill", predicate: approvedPredicate)
        //var query = {
        //    recordType: "resiliencySkill"
        //}
        //        publicDB.performQuery(query, inZoneWithID: nil) {
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()){
                    self.delegate?.errorUpdating(error!)
                    self.errorUpdating(error!)
                    print("error loading")
                    
                }
            }
            else {
                self.items.removeAll(keepCapacity: true)
                for record in results! {
                    let skill = Skill(record: record, database: self.publicDB)
                    self.items.append(skill)
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.delegate?.modelUpdated()
                print("")
            }
        }
    }
    func fetchSkills() {
        let approvedPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "resiliencySkill", predicate: approvedPredicate)
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            var res = [Skill]()
            if let records = results {
                for record in records {
                    
                    let skill = Skill(record: record as CKRecord, database:self.publicDB)
                    res.append(skill)
                }
            }
            
            /*dispatch_async(dispatch_get_main_queue()) {
                completion(results: res, error: error)
            }*/
        }

    }
    func errorUpdating(error: NSError) {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Error Loading Skills",
            message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

}
    
let modelSingletonGlobal = Model()