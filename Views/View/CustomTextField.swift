//
//  CustomTextField.swift
//  Food
//
//  Created by Emir Rassulov on 01/02/2024.
//


import SwiftUI

struct CustomTextField: View {

    var image: String
    var title: String
    @Binding var value: String
    @State private var isSecureTextEntry: Bool = true // Added for password visibility

    var animation: Namespace.ID

    var body: some View {

        VStack(spacing: 6) {

            HStack(alignment: .bottom) {

                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(value == "" ? .gray : .primary)
                    .frame(width: 35)

                VStack(alignment: .leading, spacing: 6) {

                    if value != "" {

                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }

                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {

                        if value == "" {

                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }

                        if title == "PASSWORD" {

                            if isSecureTextEntry {
                                SecureField("", text: $value)
                            } else {
                                TextField("", text: $value)
                            }

                            HStack {
                                Spacer()
                                Button(action: {
                                    isSecureTextEntry.toggle()
                                }) {
                                    Image(systemName: isSecureTextEntry ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                                .padding(.bottom, 8)
                            }
                        } else {
                            TextField("", text: $value)
                        }
                    }
                }
            }

            if value == "" {
                Divider()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("txt").opacity(value != "" ? 1 : 0))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
        .padding(.horizontal)
        .padding(.top)
        .animation(.linear)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(image: "envelope", title: "EMAIL", value: .constant("Test"), animation: Namespace().wrappedValue)
    }
}

