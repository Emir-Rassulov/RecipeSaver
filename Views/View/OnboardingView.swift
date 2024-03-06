//
//  OnboardingView.swift
//  Food
//
//  Created by Emir Rassulov on 01/02/2024.
//


import SwiftUI

struct OnboardingView: View {
    @State private var showLogin = false

    var body: some View {
        VStack {
            VStack {
                Image("ContentView2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 1000, height: 500)
                    .padding(.top, 100)

                Text("Start Cooking")
                    .font(Font.headline.weight(.bold))
                    .foregroundColor(Color("maintext"))
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                Text("Let’s join our community to cook better food!")
                    .foregroundColor(Color("secondaryText"))
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)

            Spacer()

            VStack {
                Button(action: {
                    showLogin = true
                }) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.green)
                        .frame(height: 50)
                        .padding([.leading, .trailing], 20)
                        .overlay(HStack {
                            Text("Get Started")
                                .foregroundColor(.white)
                                .font(Font.headline.weight(.bold))
                        })
                }
                .padding(.top, 70)
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
            }
        }
        .padding(.bottom, 160)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewInterfaceOrientation(.portrait)
    }
}
