//
//  OTPVerificationView.swift
//  Food
//
//  Created by Emir Rassulov on 05/02/2024.
//





import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct OTPVerificationView: View {
    @State var otpText: String = ""
    @FocusState private var isKeyboardShowing: Bool

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { index in
                OTPTextBox(index)
            }
        }
        .background {
            TextField("", text: $otpText)
                .onChange(of: otpText) { newValue in
                    otpText = String(newValue.prefix(6))
                }
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .opacity(0)  // Make the TextField transparent
                .focused($isKeyboardShowing)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing = true
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isKeyboardShowing = false
                }
                .tint(.primary)
            }
        }
    }

    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            let status = (isKeyboardShowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? .blue : Color.gray, lineWidth: status ? 3 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: isKeyboardShowing)
        }
        .frame(maxWidth: .infinity)
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
