//
//  FoodApp.swift
//  Food
//
//  Created by Emir Rassulov on 19/02/2024.
//

import SwiftUI
import Firebase

@main
struct FoodApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
            FirebaseApp.configure()
        }
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}


