//
//  BottomView.swift
//  Food
//
//  Created by Emir Rassulov on 02/02/2024.
//

import SwiftUI

struct BottomView: View {
    var googleAction: () -> Void
    var facebookAction: () -> Void
    var appleAction: () -> Void

    var body: some View {
        VStack {
            Text("- Or continue with -")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("secondaryText"))
                .padding(.bottom)

            HStack {
                Button(action: {
                    googleAction()
                }) {
                    Image("google-logo")
                }
                .iconButtonStyle()

                Button(action: {
                    facebookAction()
                }) {
                    Image("facebook-logo")
                }
                .iconButtonStyle()

                Button(action: {
                    appleAction()
                }) {
                    Image("apple-logo")
                }
                .iconButtonStyle()
            }
        }
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView(
            googleAction: {},
            facebookAction: {},
            appleAction: {}
        )
    }
}

extension View {
    func iconButtonStyle() -> some View {
        self
            .padding()
            .background(Color("lightGray"))
            .cornerRadius(8)
    }
}
