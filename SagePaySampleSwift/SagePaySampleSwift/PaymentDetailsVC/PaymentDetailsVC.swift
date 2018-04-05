//
//  PaymentDetailsVC.swift
//  SagePaySampleSwift
//
//  Created by Pawan on 28/03/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

class PaymentDetailsVC: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var addressline1Label: UILabel!
    @IBOutlet weak var addressline2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.amountLabel.text = "50.55"
        self.firstnameLabel.text = "Pawan"
        self.surnameLabel.text = "Sharma"
        self.addressline1Label.text = "Sector 15"
        self.addressline2Label.text = "Near PNB Bank"
        self.cityLabel.text = "Noida"
        self.stateLabel.text = "Uttar Pradesh"
        self.countryLabel.text = "India"
        self.phonenumberLabel.text = "9910xxxxxx"
        self.emailLabel.text = "pawanxxxx@gmail.com"
        self.pincodeLabel.text = "201301"
        
        // Initialize the Dictionary
        var dictionary = [String : Any]()
        
        dictionary["amount"] = self.amountLabel.text
        dictionary["countryName"] = self.countryLabel.text
        dictionary["countryCode"] = "IN"
        dictionary["mobileCode"] = "+91"
        dictionary["mobileNumber"] = self.phonenumberLabel.text
        dictionary["fullName"] = "\(self.firstnameLabel.text ?? "") \(self.surnameLabel.text ?? "")"
        dictionary["email"] =  self.emailLabel.text
        dictionary["address1"] =  self.addressline1Label.text
        dictionary["address2"] =  self.addressline2Label.text //Optional
        dictionary["city"] =  self.cityLabel.text
        dictionary["state"] =  self.stateLabel.text
        dictionary["postalCode"] = self.pincodeLabel.text
        
        print("BILLINGADDRESS SEND ---> \(dictionary)")
        
        //Set BILLINGADDRESS Data
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: dictionary) as NSData
        UserDefaults.standard.set(data, forKey: "BILLINGADDRESS")
        UserDefaults.standard.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sagePaymentButtonTap(_ sender: Any) {
        
        //Goto SagePayVC Screen
        let sagePayVC = (self.storyboard?.instantiateViewController(withIdentifier: "SagePayVC"))! as UIViewController
        self.navigationController?.pushViewController(sagePayVC, animated: true)
        //self.present(sagePayVC, animated: true, completion: nil)
        
    }
    
}

