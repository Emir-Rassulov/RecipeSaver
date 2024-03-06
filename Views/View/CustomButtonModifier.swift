//
//  CustomButtonModifier.swift
//  Login_Scroll
//
//  Created by Balaji on 18/10/20.
//


//import SwiftUI
//
//struct CustomButtonModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(.white)
//            .padding(.vertical)
//            .padding(.horizontal, 35)
//            .background(
//                LinearGradient(gradient: .init(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
//            )
//            .clipShape(Capsule())
//    }
//}
//
//struct CustomButtonModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("Preview Text")
//            .modifier(CustomButtonModifier())
//    }
//}
import SwiftUI

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(.vertical, 10)  // Adjust the vertical padding here
            .padding(.horizontal, 35)
            .background(
                LinearGradient(gradient: .init(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}

struct CustomButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Preview Text")
            .modifier(CustomButtonModifier())
    }
}
