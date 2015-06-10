//
//  DetailViewController.swift
//  SERV Resilliency
//
//  Created by Todd Crane on 6/8/15.
//  Copyright © 2015 Todd Crane. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var skillTitle: UITextField!
    @IBOutlet weak var labelSkillTitle: UILabel!
    @IBOutlet weak var skillProtected: UISwitch!
    @IBOutlet weak var skillBody: UITextView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        
        
        print(self)
        if let detail = self.detailItem {
            print("hello")
            //if self.detailItem is Skill {
                let skill = self.detailItem as! Skill
                self.navigationItem.title = detail.valueForKey("name")!.description
                if let title = self.skillTitle {
                    title.text = detail.name
                }
                
                //if let protected = self.skillProtected {
                    //protected.on = detail.protected
                //}
                if let body = self.skillBody {
                    body.text = skill.body
                }
           /* }
            else {
                self.navigationItem.title = detail.valueForKey("name")!.description
                if let title = self.skillTitle {
                    title.text = detail.valueForKey("name")!.description
                }
            
                if let protected = self.skillProtected {
                    protected.on = detail.valueForKey("protected")!.boolValue
                }
                if let body = self.skillBody {
                    body.text = detail.valueForKey("body")!.description
                }
            }*/
        }
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (self.editing) {
            
            if let name = self.skillTitle {
                name.hidden = false
                name.enabled = true
            }
            if let labelTitle  = self.labelSkillTitle {
                labelTitle.hidden = false
            }
            if let body = self.skillBody {
                body.editable = true
            }
            if let protected = self.skillProtected {
                protected.hidden = false
                protected.enabled = true
            }
        }
        else {
            if let detail = self.detailItem {
                if let name = self.skillTitle {
                    name.hidden = true
                    name.enabled = false
                    detail.setValue(name.text, forKey: "name")
                    self.navigationItem.title = detail.valueForKey("name")!.description
                }
                if let labelTitle  = self.labelSkillTitle {
                    labelTitle.hidden = true
                }
                if let body = self.skillBody {
                    body.editable = false
                    detail.setValue(body.text, forKey: "body")
                    
                }
                if let protected = self.skillProtected {
                    protected.hidden = true
                    protected.enabled = false
                    detail.setValue(protected.on, forKey: "protected")
                }
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detail = self.detailItem {
            if let name = self.skillTitle {
                detail.setValue(name.text, forKey: "name")
            }
            if let body = self.skillBody {
                detail.setValue(body.text, forKey: "body")
                
            }
            if let protected = self.skillProtected {
                detail.setValue(protected.on, forKey: "protected")
            }
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

