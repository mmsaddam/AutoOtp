//
//  VerificationView.swift
//  AutoOtp
//
//  Created by Muzahid on 13/12/22.
//

import SwiftUI

struct VerificationView: View {
    @ObservedObject var viewModel: OtpViewModel = .init()
    @FocusState var activeField: OtpField?
    
    var body: some View {
        VStack {
           otpField()
            
            Button {
                
            } label: {
                Text("Verify")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)
                    }
            }
            .disabled(checkState())
            .opacity(checkState() ? 0.5 : 1.0)
            .padding(.vertical)
            
            
            HStack(spacing: 12) {
                Text("Didn't get otp?")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button("Resend") {
                    
                }
                .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .onChange(of: viewModel.fields) { newValue in
            checkConditions(value: newValue)
        }
        
    }
    
    func checkState() -> Bool {
        for index in 0..<6 {
            if viewModel.fields[index].isEmpty {
                return true
            }
        }
        return false
    }
    
    func checkConditions(value: [String]) {
        /// Focus next field
        for index in 0..<5 {
            if value[index].count == 1 && activeField == activeFieldForIndex(index) {
                activeField = activeFieldForIndex(index + 1)
            }
        }
        
        /// Moving back when current is empty and previous is not empty
        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeFieldForIndex(index - 1)
            }
        }
        
        /// Restricted to single character
        for index in 0..<6 {
            if value[index].count > 1 {
                viewModel.fields[index] = String(value[index].first!)
            }
        }
    }
    
    
    @ViewBuilder func otpField() -> some View {
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self) { index in
                VStack(spacing: 8) {
                    TextField("", text: $viewModel.fields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeFieldForIndex(index))
                        
                    Rectangle()
                        .fill(activeField == activeFieldForIndex(index) ? .blue : .gray)
                        .frame(height: 4)
                }
                .frame(height: 40)
                
            }
            
        }
    }
    
    func activeFieldForIndex(_ index: Int) -> OtpField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
}


struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}

enum OtpField: Hashable {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
    
}
