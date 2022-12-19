//
//  DefaultInputField.swift
//  AutoOtp
//
//  Created by Muzahid on 19/12/22.
//

import SwiftUI

struct DefaultInputField: View {
    @Binding var text: String
    var isFocused: Bool
    var body: some View {
        VStack(spacing: 8) {
            TextField("", text: $text)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .multilineTextAlignment(.center)
            
            Rectangle()
                .fill(isFocused ? .blue : .gray)
                .frame(height: 4)
        }
        .frame(height: 40)
    }
}



