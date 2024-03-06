//
//  ForgotPassword.swift
//  Food
//
//  Created by Emir Rassulov on 05/02/2024.
//


import SwiftUI
import FirebaseAuth

struct ForgotPassword: View {
    @Binding var showResetView: Bool
    @State private var emailID: String = ""
    @State private var resetLinkSent: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)

            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 5)
                .foregroundColor(Color("maintext"))

            Text("Please enter your Email so that we can send the reset link.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
                .foregroundColor(Color("secondaryText"))

            VStack(spacing: 25) {
                CustomTextField(image: "envelope", title: "Email", value: $emailID, animation: Namespace().wrappedValue)

                HStack {
                    Button(action: {
                        // Perform Firebase password reset
                        Auth.auth().sendPasswordReset(withEmail: emailID) { error in
                            if let error = error {
                                print("Error sending reset link: \(error.localizedDescription)")
                                // Handle the error, e.g., show an alert
                            } else {
                                // Reset link sent successfully
                                resetLinkSent = true
                            }
                        }
                    }) {
                        HStack {
                            Text("Send Link")
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(Capsule())
                    }
                    .disabled(emailID.isEmpty)
                    .padding(.trailing)
                }
                .padding(.top, 20)
            }

            // Display a message when the reset link is sent
            if resetLinkSent {
                Text("Reset link sent! Check your email.")
                    .foregroundColor(.green)
                    .padding(.top, 10)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}
