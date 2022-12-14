//
//  VerificationView.swift
//  AutoOtp
//
//  Created by Muzahid on 13/12/22.
//

import SwiftUI

struct OtpInputView: View {
    @ObservedObject var viewModel: OtpViewModel = .init()
    @FocusState var activeFieldIdx: Int?
    
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
    
    private func checkState() -> Bool {
        for index in 0..<viewModel.otpLen {
            if viewModel.fields[index].isEmpty {
                return true
            }
        }
        return false
    }
    
    private func checkConditions(value: [String]) {
        /// Focus next field
        for index in 0..<viewModel.otpLen - 1 {
            if value[index].count == 1 && activeFieldIdx == index {
                activeFieldIdx = index + 1
            }
        }
        
        /// Moving back when current is empty and previous is not empty
        for index in 1..<viewModel.otpLen  {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeFieldIdx = index - 1
            }
        }
        
        /// Restricted to single character
        for index in 0..<viewModel.otpLen {
            if value[index].count > 1 {
                viewModel.fields[index] = String(value[index].first!)
            }
        }
    }
    
    
    @ViewBuilder private func otpField() -> some View {
        HStack(spacing: 14) {
            ForEach(0..<viewModel.otpLen, id: \.self) { index in
                VStack(spacing: 8) {
                    TextField("", text: $viewModel.fields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeFieldIdx, equals: index)
                    
                    Rectangle()
                        .fill(activeFieldIdx == index ? .blue : .gray)
                        .frame(height: 4)
                }
                .frame(height: 40)
                
            }
            
        }
    }
    
}


struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        OtpInputView()
    }
}
