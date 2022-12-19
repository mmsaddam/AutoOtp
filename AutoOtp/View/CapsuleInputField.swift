//
//  CapsuleInputField.swift
//  AutoOtp
//
//  Created by Muzahid on 19/12/22.
//

import SwiftUI

struct CapsuleInputField: View {
    @Binding var text: String
    var isFocused: Bool
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.5))
            )
        
    }
}
