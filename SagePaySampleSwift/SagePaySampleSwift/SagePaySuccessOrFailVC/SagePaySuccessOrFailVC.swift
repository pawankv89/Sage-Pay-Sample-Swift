//
//  SagePaySuccessVC.swift
//  SagePaySampleSwift
//
//  Created by Pawan on 28/03/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

class SagePaySuccessOrFailVC : UIViewController {
    
    @IBOutlet weak var bookingStatusMainHeader: UILabel!
    @IBOutlet weak var bookingSubHeading: UILabel!
    @IBOutlet weak var pnrNumberOUtlet: UILabel!
    @IBOutlet weak var statusImageViewOUtlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retriveSAGEPAYMENT() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retriveSAGEPAYMENT() -> Void {
        
        if let retriveSAGEPAYMENTData = UserDefaults.standard.object(forKey: "SAGEPAYMENT"){
            
            let billingDict = NSKeyedUnarchiver.unarchiveObject(with: (retriveSAGEPAYMENTData as! NSData) as Data)
            let dictionary = billingDict as! [String : Any]
            
            print("SAGEPAYMENT RECIVED ---> \(dictionary)")
            
            var Status : String = ""
            var Amount : String = ""
            var PostCodeResult : String = ""
            var DeclineCode : String = ""
            var VPSTxId : String = ""
            var GiftAid : String = ""
            var VendorTxCode : String = ""
            var TxAuthNo : String = ""
            var BankAuthCode : String = ""
            var AddressResult : String = ""
            var AVSCV2 : String = ""
            var DSecureStatus : String = ""
            var ExpiryDate : String = ""
            var CardType : String = ""
            var Last4Digits : String = ""
            var StatusDetail : String = ""
            var CV2Result : String = ""
            
            if (dictionary["Status"] != nil) {
                
                Status = dictionary["Status"] as! String
            }
            if (dictionary["Amount"] != nil) {
                
                Amount = dictionary["Amount"] as! String
            }
            if (dictionary["PostCodeResult"] != nil) {
                
                PostCodeResult = dictionary["PostCodeResult"] as! String
            }
            if (dictionary["DeclineCode"] != nil) {
                
                DeclineCode = dictionary["DeclineCode"] as! String
            }
            if (dictionary["VPSTxId"] != nil) {
                
                VPSTxId = dictionary["VPSTxId"] as! String
            }
            if (dictionary["GiftAid"] != nil) {
                
                GiftAid = dictionary["GiftAid"] as! String
            }
            if (dictionary["VendorTxCode"] != nil) {
                
                VendorTxCode = dictionary["VendorTxCode"] as! String
            }
            if (dictionary["TxAuthNo"] != nil) {
                
                TxAuthNo = dictionary["TxAuthNo"] as! String
            }
            if (dictionary["BankAuthCode"] != nil) {
                
                BankAuthCode = dictionary["BankAuthCode"] as! String
            }
            if (dictionary["AddressResult"] != nil) {
                
                AddressResult = dictionary["AddressResult"] as! String
            }
            if (dictionary["AVSCV2"] != nil) {
                
                AVSCV2 = dictionary["AVSCV2"] as! String
            }
            if (dictionary["3DSecureStatus"] != nil) {
                
                DSecureStatus = dictionary["3DSecureStatus"] as! String
            }
            if (dictionary["ExpiryDate"] != nil) {
                
                ExpiryDate = dictionary["ExpiryDate"] as! String
            }
            if (dictionary["CardType"] != nil) {
                
                CardType = dictionary["CardType"] as! String
            }
            if (dictionary["Last4Digits"] != nil) {
                
                Last4Digits = dictionary["Last4Digits"] as! String
            }
            if (dictionary["StatusDetail"] != nil) {
                
                StatusDetail = dictionary["StatusDetail"] as! String
            }
            if (dictionary["CV2Result"] != nil) {
                
                CV2Result = dictionary["CV2Result"] as! String
            }
            
            //Booking Status Depand on "Status"
            //If Status
            
            var bookingStatus : String = ""
            
            if Status == "OK"{
                
                self.bookingStatusMainHeader.text = "PAYMENT CONFIRMED"
                self.bookingStatusMainHeader.textColor = UIColor.white
                self.bookingStatusMainHeader.backgroundColor = UIColor.green
                
                bookingStatus = "\("Thank you for choosing SagePay, your payment is confirmed and reference number is -")-\(VendorTxCode)"
                
                self.statusImageViewOUtlet.image = UIImage.init(named: "payment-success")
            }
            else{
                
                self.bookingStatusMainHeader.text = "PAYMENT NOT CONFIRMED"
                self.bookingStatusMainHeader.textColor = UIColor.white
                self.bookingStatusMainHeader.backgroundColor = UIColor.red
                
                bookingStatus = "\("Thank you for choosing SagePay, your payment is not confirmed and reference number is -")-\(VendorTxCode)"
                
                self.statusImageViewOUtlet.image = UIImage.init(named: "payment-error")
            }
            
            //Show PNR Number
            self.pnrNumberOUtlet.text = VendorTxCode
            
            self.bookingSubHeading.text = bookingStatus
        }
    }
    
    @IBAction func sagePaymentButtonTap(_ sender: Any) {
        
        //Move To Home Screen
    }
    
}

