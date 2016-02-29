//
//  ViewController.swift
//  Safety
//
//  Created by Trong Le on 2/12/16.
//  Copyright © 2016 Trong Le. All rights reserved.
//

import UIKit
import CoreData

class SaveContactViewController: UIViewController, UITextFieldDelegate {
    
    var setNameText: String?
    var setNumberText: String?
    var setEmailText: String?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        phoneNumberField.delegate = self
        
        if (setNameText?.isEmpty == false) {
            nameField.text = setNameText
        }
        
        if (setNumberText?.isEmpty == false) {
            phoneNumberField.text = setNumberText
        }
        
        if (setEmailText?.isEmpty == false) {
            emailField.text = setEmailText
        }
        
    }
    
    // Save contact information
    @IBAction func saveContact(sender: UIButton) {
        
        let alert = UIAlertController(title: "Empty Fields Detected", message: "Must populate all boxes to continue.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .Default, handler: nil))
        
        if (nameField.text?.isEmpty == true || phoneNumberField.text?.isEmpty == true || emailField.text?.isEmpty == true) {
            presentViewController(alert, animated: true, completion: nil)
        } else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("Contact", inManagedObjectContext: managedContext)
            
            let contact = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            contact.setValue(nameField.text!, forKey: "name")
            contact.setValue(phoneNumberField.text!, forKey: "phoneNumber")
            contact.setValue(emailField.text, forKey: "email")
            
            do {
                try managedContext.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nameField.resignFirstResponder()
        self.phoneNumberField.resignFirstResponder()
        self.emailField.resignFirstResponder()
    }
    
    
    // Dismiss keyboard when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.phoneNumberField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        return true
    }
    
    


}

