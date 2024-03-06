//
//  RegisterView.swift
//  Food
//
//  Created by Emir Rassulov on 01/02/2024.
//


import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    @State private var number = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    @State private var showSheet = false

    @Binding var show: Bool
    @Namespace var animation
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authViewModel = AuthViewModel()

    let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .padding(.leading)

                HStack {
                    Text("Create Account")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("maintext"))
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading)

                CustomTextField(image: "person", title: "FULL NAME", value: $name, animation: animation)

                CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .padding(.top, 5)
                    .onChange(of: email) { newValue in
                        validateEmail()
                    }

                if let emailError = emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .padding(.leading, 15)
                        .padding(.top, -5)
                }

                CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                    .padding(.top, 5)
                    .onChange(of: password) { newValue in
                        validatePassword()
                    }

                if let passwordError = passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .padding(.leading, 15)
                        .padding(.top, -5)
                }

                HStack {
                    Spacer()
                    Button(action: {
                       
                        signUp()
                    }) {
                        HStack(spacing: 10) {
                            Text("Sign up")
                                .fontWeight(.heavy)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                            Image(systemName: "arrow.right")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .black : .white)

                        }
                        .modifier(CustomButtonModifier())
                    }
                }
                .padding()
                .padding(.top)
                .padding(.trailing)

                HStack {
                    Text("Already have an account?")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("secondaryText"))
                    Button(action: {
                        show = false
                    }) {
                        Text("Sign in")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("primary"))
                    }
                }
                .padding()
                .padding(.top, 100)

                BottomView(
                    googleAction: { /* Add your Google login action */ },
                    facebookAction: { /* Add your Facebook login action */ },
                    appleAction: { /* Add your Apple login action */ }
                )
                .padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $showSheet) {
            PopUp(isPresented: $showSheet, successType: .registration)
        }
    }

    private func signUp() {
        
        guard isValidEmail && isValidPassword else {
            return
        }

        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
              
                print("Error creating user: \(error.localizedDescription)")
            } else {
               
                print("User created successfully!")

                showSheet = true
            }
        }
    }

    private func validateEmail() {
        if !email.isEmpty, !email.isValidEmail() {
            emailError = "Your email is not valid!"
        } else {
            emailError = nil
        }
    }

    private func validatePassword() {
        passwordError = nil
        if !password.isEmpty, !password.matchesRegex(passwordRegex) {
            passwordError = "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character."
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(show: .constant(false))
    }
}



