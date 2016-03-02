//
//  ContactListViewController.swift
//  Safety
//
//  Created by Trong Le on 2/12/16.
//  Copyright © 2016 Trong Le. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UIViewController {
    
    var names = [String]()
    var phoneNumbers = [String]()
    var emails = [String]()
    var index = 0
    
    @IBOutlet weak var contactOne: UIButton!
    @IBOutlet weak var contactTwo: UIButton!
    @IBOutlet weak var contactThree: UIButton!
    @IBOutlet weak var contactFour: UIButton!
    @IBOutlet weak var contactFive: UIButton!
    
    
    func updateContactList() {
        if  names.count > 0 {
            contactOne.setTitle(names[0], forState: UIControlState.Normal)
        }
        if names.count > 1 {
            contactTwo .setTitle(names[1], forState: UIControlState.Normal)
        }
        if names.count > 2  {
            contactThree.setTitle(names[2], forState: UIControlState.Normal)
        }
        if names.count > 3  {
            contactFour.setTitle(names[3], forState: UIControlState.Normal)
        }
        if names.count > 4  {
            contactFive.setTitle(names[4], forState: UIControlState.Normal)
        }
    }
    
    
    func fetchData() {
        // Get data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        
        do {
            
            let data = try managedContext.executeFetchRequest(fetchRequest)
            
            // Add phone numbers to message recipients array
            while index < data.count {
                let contact = data[index] as! NSManagedObject
                let name = contact.valueForKey("name")
                names.append(name as! String)
                
                let phone = contact.valueForKey("phoneNumber")
                phoneNumbers.append(phone as! String)
                
                let email = contact.valueForKey("email")
                emails.append(email as! String)
                index++
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        updateContactList()
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        fetchData()
//        
//        updateContactList()
//    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Pass values to SaveContactVC and populate values if not nil
        if let savedContacts = segue.destinationViewController as? SaveContactViewController {
            
            switch segue.identifier! {
            case "contactOne":
                if names.count > 0 {
                    savedContacts.setNameText = names[0]
                }
                if phoneNumbers.count > 0 {
                    savedContacts.setNumberText = phoneNumbers[0]
                }
                if emails.count > 0 {
                    savedContacts.setEmailText = emails[0]
                }
                
                savedContacts.contactIndex = 0
            case "contactTwo":
                if names.count > 1 {
                    savedContacts.setNameText = names[1]
                }
                if phoneNumbers.count > 1 {
                    savedContacts.setNumberText = phoneNumbers[1]
                }
                if emails.count > 1 {
                    savedContacts.setEmailText = emails[1]
                }
                
                savedContacts.contactIndex = 1
            case "contactThree":
                if names.count > 2 {
                    savedContacts.setNameText = names[2]
                }
                if phoneNumbers.count > 2 {
                    savedContacts.setNumberText = phoneNumbers[2]
                }
                if emails.count > 2 {
                    savedContacts.setEmailText = emails[2]
                }
                
                savedContacts.contactIndex = 2
            case "contactFour":
                if names.count > 3 && phoneNumbers.count > 3 && emails.count > 3 {
                    savedContacts.setNameText = names[3]
                }
                if phoneNumbers.count > 3 {
                    savedContacts.setNumberText = phoneNumbers[3]
                }
                if emails.count > 3 {
                    savedContacts.setEmailText = emails[3]
                }
                
                savedContacts.contactIndex = 3
            case "contactFive":
                if names.count > 4 {
                    savedContacts.setNameText = names[4]
                }
                if phoneNumbers.count > 4 {
                    savedContacts.setNumberText = phoneNumbers[4]
                }
                if emails.count > 4 {
                    savedContacts.setEmailText = emails[4]
                }
                
                savedContacts.contactIndex = 4
            default:
                break
            }
        }
        
    }
    

}
