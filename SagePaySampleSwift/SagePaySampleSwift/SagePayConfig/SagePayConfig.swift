//
//  SagePayConfig.swift
//  SagePaySampleSwift
//
//  Created by Pawan on 28/03/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

struct SagePayConfig {
    
    //SagePayment credentials
    static let sagePay_TESTURL :String = "https://test.sagepay.com/gateway/service/vspform-register.vsp"
    static let sagePay_LIVEURL :String = "https://live.sagepay.com/gateway/service/vspform-register.vsp"
    static let sagePay_SuccessURL :String = "https://pawankv89.github.io/SagePaySuccess/index.html"
    static let sagePay_FailureURL :String = "https://pawankv89.github.io/SagePayFailed/index.html"
    static let sagePay_VendorEmail :String = "gopalreddy2440@gmail.com"
    static let sagePay_VPSProtocol :String = "3.00"
    static let sagePay_TxType :String = "DEFERRED" //OR "PAYMENT"
    static let sagePay_Vendor :String = "protxross"
    static let sagePay_Password :String = "TPjs72eMz5qBnaTa"
    
    /*
     Visa Debit
     
     4900 0000 0000 0003
     03/2019  Current Month with Current Year
     123
     
     //Visa
     //4929 0000 0555 9
     //01/18
     //123
     
     //Amex
     //3742 0000 0000 004
     //01/18
     //1234
     
     */
    
}
