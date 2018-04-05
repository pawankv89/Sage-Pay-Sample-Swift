//
//  SagePayVC.swift
//  SagePaySampleSwift
//
//  Created by Pawan on 28/03/18.
//  Copyright © 2018 Pawan. All rights reserved.
//
//  https://www.sagepay.co.uk/support/test-your-integration/process-a-test-transaction

import Foundation
import UIKit

class SagePayVC: UIViewController , UIWebViewDelegate {
    
    @IBOutlet weak var webView : UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    var webLoadString = ""
    var base64Key = ""
    var dataString = ""
    
    var successURLChecked :Bool = false
    var failureURLChecked :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Show Loader
        activityIndicator.isHidden = false
        loadingLabel.isHidden = false
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        
        //Process For Payment
        retriveBILLINGADDRESS()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- BILLINGADDRESS
    
    func retriveBILLINGADDRESS() -> Void {
        
        if let retriveBILLINGADDRESSDate = UserDefaults.standard.object(forKey: "BILLINGADDRESS"){
            
            let billingDict = NSKeyedUnarchiver.unarchiveObject(with: (retriveBILLINGADDRESSDate as! NSData) as Data)
            let dictionary = billingDict as! [String : Any]
            
            print("BILLINGADDRESS RECIVED ---> \(dictionary)")
            
            let amountPayble : String = dictionary["amount"] as! String
            let countryName : String = dictionary["countryName"] as! String
            let countryCode : String = dictionary["countryCode"] as! String
            let mobileCode : String = dictionary["mobileCode"] as! String
            let mobileNumber : String = dictionary["mobileNumber"] as! String
            let fullName : String = dictionary["fullName"] as! String
            let email : String = dictionary["email"] as! String
            let address1 : String = dictionary["address1"] as! String
            let address2 : String = dictionary["address2"] as! String
            let city : String = dictionary["city"] as! String
            let state : String = dictionary["state"] as! String
            let postalCode : String = dictionary["postalCode"] as! String
            
            var fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
            let firstName: String = fullNameArr[0]
            let lastName: String = fullNameArr.count > 1 ? fullNameArr[1] : fullNameArr[0]
            
            let billingCityState = "\(city, state)"
            
            let deliveryAddress = "\(address1, address2)"
            
            let billingPhoneNumber = "\(mobileCode, mobileNumber)"
            
            //SagePayment credentials
            let baseURL :String = SagePayConfig.sagePay_TESTURL
            let vendorTxCode :String = String.random(length: 16)
            let amount :String = amountPayble
            let currency :String = "GBP"
            let description :String = "Booking from iOS Product Name App"
            let surname :String = lastName
            let customerEMail :String = email
            let vendorEMail :String = SagePayConfig.sagePay_VendorEmail
            let billingFirstnames :String = firstName
            let billingSurname :String = lastName
            let billingAddress1 :String = deliveryAddress
            let billingCity :String = billingCityState
            let billingPostCode :String = postalCode
            let billingCountry :String = countryCode
            let billingPhone :String = billingPhoneNumber
            let deliveryFirstnames :String = firstName
            let deliverySurname :String = lastName
            let deliveryAddress1 :String = deliveryAddress
            let deliveryCity :String = billingCityState
            let deliveryPostCode :String = postalCode
            let deliveryCountry :String = countryCode
            let deliveryPhone :String = billingPhoneNumber
            let successURL :String = SagePayConfig.sagePay_SuccessURL
            let failureURL :String = SagePayConfig.sagePay_FailureURL
            
            //Other Params
            let VPSProtocol :String = SagePayConfig.sagePay_VPSProtocol
            let TxType :String = SagePayConfig.sagePay_TxType
            let Vendor :String = SagePayConfig.sagePay_Vendor
            //Convert Pass to base64 Key
            let sagePay_Password = SagePayConfig.sagePay_Password
            
            let data_sagePay_Password = (sagePay_Password).data(using: String.Encoding.utf8)
            self.base64Key = data_sagePay_Password!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            print("base64: \(self.base64Key)") //MDM0OGI5ODk3ZjZhZWNkYg==
            
            //First Time Setup
            successURLChecked  = false
            failureURLChecked  = false
            
            self.dataString = "VendorTxCode=\(vendorTxCode)&Amount=\(amount)&Currency=\(currency)&Description=\(description)&Surname=\(surname)&CustomerEMail=\(customerEMail)&VendorEMail=\(vendorEMail)&BillingSurname=\(billingSurname)&BillingFirstnames=\(billingFirstnames)&BillingAddress1=\(billingAddress1)&BillingCity=\(billingCity)&BillingPostCode=\(billingPostCode)&BillingCountry=\(billingCountry)&BillingPhone=\(billingPhone)&DeliveryFirstnames=\(deliveryFirstnames)&DeliverySurname=\(deliverySurname)&DeliveryAddress1=\(deliveryAddress1)&DeliveryCity=\(deliveryCity)&DeliveryPostCode=\(deliveryPostCode)&DeliveryCountry=\(deliveryCountry)&DeliveryPhone=\(deliveryPhone)&SuccessURL=\(successURL)&FailureURL=\(failureURL)"
            
            print("Send Request \(self.dataString)");
            
            let key = Data.init(base64Encoded: self.base64Key)
            let data = self.dataString.data(using:String.Encoding.utf8 , allowLossyConversion: true)
            
            let encryptedData :NSData = NSData.crypt(data, iv: key, key: key, context: CCOperation(kCCEncrypt))! as NSData;
            let  hex111 = encryptedData.hexadecimalString() as String;
            
            self.webLoadString = "\(baseURL)?VPSProtocol=\(VPSProtocol)&TxType=\(TxType)&Vendor=\(Vendor)&Crypt=@\(hex111.uppercased())"
            
            //Load WebView by URL
            webViewLoadByURL(urlStr: self.webLoadString);
        }
    }
    
    func webViewLoadByURL(urlStr: String) {
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL (string: urlStr);
        let requestObj = URLRequest(url: url! as URL);
        webView.delegate = self
        webView.loadRequest(requestObj);
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        print("BB")
        
        return true
    }
    
    func webViewDidStartLoad(_ webView : UIWebView) {
        
        //Show Loader
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("AA")
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        
        //Hide Loader
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        print("CC")
        
        //Hide Loader
        activityIndicator.isHidden = true
        loadingLabel.isHidden = true
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        
        let urlString :String = (webView.request?.url!.absoluteString)!
        print("urlString--> \(urlString)")
        
        let successURL :String = SagePayConfig.sagePay_SuccessURL
        let failureURL :String = SagePayConfig.sagePay_FailureURL
        
        if let _ =  urlString.range(of: "\(successURL)") {
            
            print("string contain successURL")
            
            if successURLChecked == false {
                
                let successString : String = decryptedResponseSepratedByCrypt(text:urlString)
                let successdecodedString : String = decryptedDataWithResponse(text: successString)
                let successdecodedStringResponse : [String : Any] = convertToDictionaryManually(text: successdecodedString)
                
                //Set Data
                let data : NSData = NSKeyedArchiver.archivedData(withRootObject: successdecodedStringResponse) as NSData
                UserDefaults.standard.set(data, forKey: "SAGEPAYMENT")
                
                let status : String = successdecodedStringResponse["Status"] as! String
                if status == "OK" {
                    
                    //First Time Setup
                    successURLChecked  = true
                    failureURLChecked  = false
                    
                    gotoPaymentSuccessVC()
                    
                }
            }
            
            
        } else if let _ =  urlString.range(of: "\(failureURL)") {
            
            print("string contain failureURL")
            
            if failureURLChecked == false {
                
                let failureString : String = decryptedResponseSepratedByCrypt(text:urlString)
                let failuredecodedString : String = decryptedDataWithResponse(text: failureString)
                let failuredecodedStringResponse : [String : Any] = convertToDictionaryManually(text: failuredecodedString)
                
                //Set Data
                let data : NSData = NSKeyedArchiver.archivedData(withRootObject: failuredecodedStringResponse) as NSData
                UserDefaults.standard.set(data, forKey: "SAGEPAYMENT")
                
                /* OK ABORT REJECTED
                 
                 if status == "OK" || status == "NOTAUTHED" || status == "MALFORMED" || status == "INVALID" || status == "ABORT" || status == "REJECTED"  || status == "AUTHENTICATED" || status == "ERROR"
                 */
                
                let status : String = failuredecodedStringResponse["Status"] as! String
                if status == "OK" || status == "NOTAUTHED" || status == "MALFORMED" || status == "INVALID" || status == "ABORT" || status == "REJECTED"  || status == "AUTHENTICATED" || status == "ERROR" {
                    
                    //First Time Setup
                    successURLChecked  = false
                    failureURLChecked  = true
                    
                    gotoPaymentFailVC()
                }
            }
        }
        else {
            
            print("string does not contain URL")
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        
        //Hide Loader
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //Hide Loader
        activityIndicator.isHidden = true
        loadingLabel.isHidden = true
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        
        print("DD")
    }
    
    func decryptedResponseSepratedByCrypt(text: String)->String {
        
        var randomString: String = ""
        let characterSet : CharacterSet = CharacterSet.init(charactersIn: "@")
        let seprater = text.components(separatedBy: characterSet)
        randomString = seprater[1]
        return randomString
    }
    
    func decryptedDataWithResponse(text: String)->String {
        
        var decodedString: String = ""
        
        let key = Data.init(base64Encoded: self.base64Key)
        
        let dataRecived = text.hexadecimal()! as NSData
        let decryptedData :NSData = NSData.crypt(dataRecived as Data!, iv: key, key: key, context: CCOperation(kCCDecrypt))! as NSData;
        decodedString  = NSString(data: decryptedData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return decodedString
    }
    
    func convertToDictionaryManually(text: String) ->[String : Any]{
        
        let characterSet : CharacterSet = CharacterSet.init(charactersIn: "&")
        let seprater = text.components(separatedBy: characterSet)
        //print(seprater)
        
        // Initialize the Dictionary
        var dictionary = [String : Any]()
        
        for keyStrin in seprater{
            
            let characterSet : CharacterSet = CharacterSet.init(charactersIn: "=")
            let seprater = keyStrin.components(separatedBy: characterSet)
            print(seprater)
            
            dictionary[seprater[0]] = seprater[1]
        }
        
        print("dictionary---> \(dictionary)" )
        
        return dictionary
    }
    
    func gotoPaymentSuccessVC(){
        
        //Goto SagePaySuccessOrFailVC Screen
        let sagePaySuccessVC = (self.storyboard?.instantiateViewController(withIdentifier: "SagePaySuccessOrFailVC"))! as UIViewController
        self.present(sagePaySuccessVC, animated: true, completion: nil)
    }
    
    func gotoPaymentFailVC(){
        
        //Goto SagePaySuccessOrFailVC Screen
        let sagePayFailVC = (self.storyboard?.instantiateViewController(withIdentifier: "SagePaySuccessOrFailVC"))! as UIViewController
        self.present(sagePayFailVC, animated: true, completion: nil)
    }
}

extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

extension String {
    
    /// Create `Data` from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a `Data` object. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    
    func hexadecimal() -> Data? {
        var data = Data(capacity: characters.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
}



