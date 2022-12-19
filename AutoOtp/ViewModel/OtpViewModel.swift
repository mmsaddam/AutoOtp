//
//  OtpViewModel.swift
//  AutoOtp
//
//  Created by Muzahid on 13/12/22.
//

import SwiftUI

class OtpViewModel: ObservableObject {
    let otpLen: Int
    static let maxLen = 8
    static let minLen = 3
    @Published var otpText: String = ""
    @Published var fields: [String] = []
    
    init(otpLen: Int = 8) {
        let notGreaterThanMax = min(otpLen, Self.maxLen)
        let notLessThanMin = max(notGreaterThanMax, Self.minLen)
        self.otpLen = notLessThanMin
        fields = Array(repeating: "", count: self.otpLen)
    }
    
    func verify() {
        otpText = fields.reduce("", { res, str in
            return res + str
        })
        print("OTP \(otpText)")
    }
}

