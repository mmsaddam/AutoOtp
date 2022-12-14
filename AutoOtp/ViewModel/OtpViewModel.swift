//
//  OtpViewModel.swift
//  AutoOtp
//
//  Created by Muzahid on 13/12/22.
//

import SwiftUI

class OtpViewModel: ObservableObject {
    @Published var optText: String = ""
    @Published var fields: [String] = Array(repeating: "", count: 6)
}

