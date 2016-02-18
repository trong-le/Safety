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
                //print(index)
                index++
            }
            print(index)
            print(names)
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

    }
    
    @IBAction func changeFirstContact(sender: UIButton) {
        
        var contact = NSManagedObject()
        
        // Get data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        
        do {
            
            let data = try managedContext.executeFetchRequest(fetchRequest)
            
            // Add phone numbers to message recipients array
            contact = data[index] as! NSManagedObject
            _ = contact.valueForKey("name")
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        //let contactID = contact.objectID
        //let predicate = NSPredicate(format: "ObjectID == \(contactID)", objectIDFromNSManagedObject)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchData()
        
        updateContactList()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
        
        updateContactList()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
