
# Sage Pay Sample iOS (Swift)

=========

## Sage Pay Sample iOS (Swift)

------------
 Added Some screens here.
 
 Visualization of SagePay Failed Page http://pawankv89.github.io/SagePayFailed/index.html
 Visualization of SagePay Success Page http://pawankv89.github.io/SagePaySuccess/index.html

![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/1.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/2.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/3.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/4.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/5.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/6.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/7.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/8.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/9.png)
![](https://github.com/pawankv89/SagePaySampleSwift/blob/master/Screens/10.png)


## Usage
------------
 iOS 9 Demo showing how to Used SagePayment on iPhone X Simulator in  Objective-C.

```Swift

Test Card Details
//Amex
//3742 0000 0000 004
//01/18
//1234

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

```


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 
