//
//  AlertViewController.swift
//  Safety
//
//  Created by Trong Le on 2/12/16.
//  Copyright © 2016 Trong Le. All rights reserved.
//

import UIKit
import MessageUI
import CoreData
import MapKit
import CoreLocation

class AlertViewController: UIViewController, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    var messageRecipients = [String]()
    var names = [String]()
    var emails = [String]()
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    // Change button to circle
    @IBOutlet weak var alertButton: UIButton! {
        didSet {
            alertButton.layer.cornerRadius = 125
        }
    }
    
    @IBAction func alertMessage(sender: UIButton) {

        locationManager.startUpdatingLocation()
        latitude = locationManager.location?.coordinate.latitude
        longitude = locationManager.location?.coordinate.longitude
        print("\(latitude)  \(longitude)")
        
        // canSendText false because simulator
        if MFMessageComposeViewController.canSendText() {
            
            print("Can send text")
            let messageVC = MFMessageComposeViewController()
            messageVC.messageComposeDelegate = self
            
            messageVC.recipients = messageRecipients
            messageVC.body = "Help! I'm at \(latitude), \(longitude) and I'm in danger!"
            
            self.presentViewController(messageVC, animated: false, completion: nil)
        }
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        // Dismiss the mail compose view controller.
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Get data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        
        do {
            
            let data = try managedContext.executeFetchRequest(fetchRequest)
            
            // Add phone numbers to message recipients array
            for var i = 0; i < data.count; i++ {
                let contact = data[i] as! NSManagedObject
                let phoneNumber = contact.valueForKey("phoneNumber")
                messageRecipients.append((phoneNumber as? String)!)
                
                let name = contact.valueForKey("name")
                names.append(name as! String)
                
                let email = contact.valueForKey("email")
                emails.append((email as? String)!)
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

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
