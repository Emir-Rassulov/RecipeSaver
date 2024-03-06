//
//  OTPView.swift
//  Food
//
//  Created by Emir Rassulov on 05/02/2024.
//



import SwiftUI
import Firebase
import FirebaseAuth

struct OTPView: View {
    @State var otpText: String = ""
    @Environment(\.dismiss) private var dismiss

    @State private var countdownTimer: Timer?
    @State private var secondsRemaining = 300

    @State private var verificationResult: VerificationResult?
    @State private var isResendingOTP = false

    var verifyAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 15)

            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color("maintext"))
                .padding(.top, 5)

            Text("A 6-digit code has been sent to your phone number.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color("maintext"))
                .padding(.top, -5)

            VStack(spacing: 25) {
                OTPVerificationView(otpText: otpText)

                Text("Code expires in: \(formattedTime)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .onAppear {
                        startTimer()
                    }
                    .onDisappear {
                        stopTimer()
                    }

                VStack(spacing: 20) {
                    Button(action: {
                        verifyOTP()
                    }, label: {
                        Text("Verify")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 85)
                            .background(
                                LinearGradient(gradient: .init(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
                            )
                            .clipShape(Capsule())
                            .padding(.trailing, 0)
                    })

                    Button(action: {
                        resendOTP()
                    }, label: {
                        Text("Send again")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("maintext"))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 62)
                            .background(Color("lightGray"))
                            .clipShape(Capsule())
                            .padding(.trailing, 0)
                            .disabled(isResendingOTP)
                    })
                }
            }
            .padding(.top, 20)

            Spacer(minLength: 0)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 35)
        .interactiveDismissDisabled()
        .alert(item: $verificationResult) { result in
            Alert(
                title: Text(result.message),
                message: nil,
                dismissButton: .default(Text("OK")) {
                    // Additional action after dismissal if needed
                }
            )
        }
    }

    private var formattedTime: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer() {
        secondsRemaining = 300
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func stopTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

    private func verifyOTP() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            print("Verification ID not found.")
            self.verificationResult = VerificationResult(message: "Verification failed!")
            return
        }

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpText)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error signing in with phone credential: \(error.localizedDescription)")
                self.verificationResult = VerificationResult(message: "Verification failed! Try again!")
            } else {
                self.verifyAction()
                self.verificationResult = VerificationResult(message: "Verification was successful!")
            }
        }
    }

    private func resendOTP() {
        guard let user = Auth.auth().currentUser else {

            return
        }

        guard let number = user.phoneNumber else {
           
            showAlert(title: "Phone Number Not Available", message: "Your phone number is not associated with your account. Please update your profile or sign in again.")
            return
        }

        isResendingOTP = true

        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error re-sending OTP: \(error.localizedDescription)")
                // Handle error, show alert, etc.
            } else {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                startTimer()
            }

            self.isResendingOTP = false
        }
    }

    private func showAlert(title: String, message: String) {
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

struct VerificationResult: Identifiable {
    let id = UUID()
    let message: String
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(verifyAction: {})
    }
}



