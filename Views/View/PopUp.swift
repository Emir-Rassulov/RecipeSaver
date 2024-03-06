//
//  PopUp.swift
//  Food
//
//  Created by Emir Rassulov on 23/02/2024.
//



import SwiftUI

struct PopUp: View {
    enum SuccessType {
        case registration
        case login
    }

    @State private var showPopup = true
    @State private var navigateToTabBar = false
    @Binding var isPresented: Bool

    @State private var navigateToLoginView = false

    var successType: SuccessType

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        self.showPopup = false
                    }
                }

            VStack {
                Image("happinessEmoji")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

                Text(successType == .registration ? "Successful Registration" : "Successful Login")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text(successType == .registration ? "You have successfully registered!" : "You have successfully logged in!")
                    .font(.body)
                    .foregroundColor(Color("maintext"))
                    .padding(.top, 10)
                    .padding(.horizontal, 20)

                Spacer()
                    .frame(height: 20)

                Button(action: {
                    withAnimation {
                        self.showPopup = false
                        if successType == .registration {
                            
                            self.navigateToLoginView = true
                        } else {
                            self.navigateToTabBar = true
                        }
                    }
                }) {
                    Text(successType == .registration ? "Login" : "Have fun")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180, height: 40)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }
                .padding(.top, 30)
            }
            .frame(width: 300, height: 400)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 20)
            .foregroundColor(Color(UIColor.label))
            .sheet(isPresented: $navigateToLoginView) {
                LoginView()
            }

            if successType == .login && navigateToTabBar {
                Home()
                    .environmentObject(RecipesViewModel())
            }
        }
    }
}

struct PopUp_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(isPresented: .constant(true), successType: .registration)
            .preferredColorScheme(.light) 
    }
}
