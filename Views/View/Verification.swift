//
//  Verification.swift
//  Food
//
//  Created by Emir Rassulov on 04/02/2024.
//


import SwiftUI
import FirebaseAuth
import Firebase

struct Verification: View {
    @EnvironmentObject var otpModel: OTPViewModel
    @FocusState var activeField: OTPField?
    
    enum OTPField {
        case field1
        case field2
        case field3
        case field4
        case field5
        case field6
    }

    var body: some View {
        VStack {
            HStack(spacing: 14) {
                ForEach(0..<6, id: \.self) { index in
                    VStack(spacing: 8) {
                        TextField("", text: $otpModel.otpFields[index])
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .multilineTextAlignment(.center)
                            .focused($activeField, equals: activeStateForIndex(index: index))

                        Rectangle()
                            .fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                            .frame(height: 4)
                    }
                    .frame(width: 40)
                }
            }

            Button("Verify OTP") {
                Task {
                    await otpModel.verifyOTP { result in
                        switch result {
                        case .success:
                            // Successfully verified OTP
                            break
                        case .failure(let error):
                            // Handle the error
                            print("Verification failed: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .disabled(checkStates())
            .opacity(checkStates() ? 0.4 : 1)
            .padding(.vertical)

            HStack(spacing: 12) {
                Text("Didn't get OTP?")
                    .font(.caption)
                    .foregroundColor(.gray)

                Button("Resend OTP") {
                    Task {
                        await otpModel.resendOTP { result in
                            switch result {
                            case .success:
                                print("OTP request successful")
                            case .failure(let error):
                                print("Error requesting OTP: \(error.localizedDescription)")
                            }
                        }
                    }
                }
                .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: otpModel.otpFields) { newValue in
            OTPCondition(value: newValue)
        }
        .alert(otpModel.errorMsg, isPresented: $otpModel.showAlert) {}
    }

    func checkStates() -> Bool {
        for index in 0..<6 {
            if otpModel.otpFields[index].isEmpty { return true }
        }

        return false
    }

    func OTPCondition(value: [String]) {
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }

        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }

        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }

    func activeStateForIndex(index: Int) -> OTPField {
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
        Verification()
    }
}
