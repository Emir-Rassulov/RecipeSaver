//
//  LoginView.swift
//  Food
//
//  Created by Emir Rassulov on 01/02/2024.
//


import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    @Namespace private var animation
    @State private var navigateToRegister = false
    @State private var showForgotPassword = false
    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var invalidPasswordMessage: String?
    @State private var showPopup = false
    @Environment(\.presentationMode) private var presentationMode
    
    let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            VStack {
                Text("Welcome Back")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color("maintext"))
                
                Text("Please enter your account here")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("secondaryText"))
            }
            .padding()
            
            Spacer()
            
            VStack {
                CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .onChange(of: email) { newValue in
                        validateEmail()
                    }
                
                if let emailError = emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                }
                
                CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                    .onChange(of: password) { newValue in
                        validatePassword()
                    }
                
                if let passwordError = passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                }
                
                if let invalidPasswordMessage = invalidPasswordMessage {
                    Text(invalidPasswordMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showForgotPassword = true
                    }) {
                        Text("Forgot your password?")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("forgotpass"))
                    }
                    .padding(.trailing, 20)
                    .sheet(isPresented: $showForgotPassword) {
                        ForgotPassword(showResetView: $showForgotPassword)
                    }
                }
            }
            .padding(.bottom, 20)
            
            HStack {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 20) {
                    Button(action: {
                        validateEmail()
                        validatePassword()
                        
                        if passwordError == nil, !isPasswordValid() {
                            invalidPasswordMessage = "Your password is invalid!"
                        } else {
                            invalidPasswordMessage = nil
                        }
                        
                        if emailError == nil, passwordError == nil, invalidPasswordMessage == nil {
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    invalidPasswordMessage = "Your credentials are invalid!"
                                } else {
                                    showPopup = true
                                }
                            }
                        }
                    }) {
                        HStack(spacing: 10) {
                            Text("Login")
                                .fontWeight(.heavy)
                                .foregroundColor(colorScheme == .dark ? .black : .white) // Adjust text color based on color scheme
                            Image(systemName: "arrow.right")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                        }
                        .modifier(CustomButtonModifier())
                    }
                }
            }
            .padding()
            .padding(.bottom, 80)
            .padding(.trailing)
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("Don't have an account?")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("secondaryText"))
                
                NavigationLink(destination: RegisterView(show: $navigateToRegister), isActive: $navigateToRegister) {
                    EmptyView()
                }
                
                Button(action: {
                    navigateToRegister = true
                }) {
                    Text("Sign Up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("primary"))
                }
            }
            .padding()
            .fullScreenCover(isPresented: $navigateToRegister) {
                RegisterView(show: $navigateToRegister)
            }
        }
        .fullScreenCover(isPresented: $showPopup) {
            //PopUp()
            PopUp(isPresented: .constant(true), successType: .login)
        }
    }
    
    func isPasswordValid() -> Bool {
        return password.matchesRegex(passwordRegex)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

extension LoginView {
    func validateEmail() {
        if !email.isEmpty, !email.isValidEmail() {
            emailError = "Your email is not valid!"
        } else {
            emailError = nil
        }
    }
    
    func validatePassword() {
        invalidPasswordMessage = nil
        if password.isEmpty {
            passwordError = nil
        } else if !password.matchesRegex(passwordRegex) {
            passwordError = "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character."
        } else {
            passwordError = nil
        }
    }
}

extension String {
    func matchesRegex(_ regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
