//
//  PasswordResetView.swift
//  Food
//
//  Created by Emir Rassulov on 04/02/2024.
//



import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct PasswordResetView: View {
   
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
           
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
              
                CustomTF(sfIcon: "lock", hint: "Password", value: $password)
                
                CustomTF(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                    .padding(.top, 5)
                
                Button(action: {
                 
                }, label: {
                    Text("Send Link")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
               
                .disabled(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
      
        .interactiveDismissDisabled()
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
