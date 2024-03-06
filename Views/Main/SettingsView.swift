//
//  SettingsView.swift
//  Food
//
//  Created by Emir Rassulov on 20/02/2024.
//



import SwiftUI

struct SettingsView: View {
    @State private var isLoggedIn = true
    @State private var showLoginView = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account").foregroundColor(.gray)) {
                    NavigationLink(destination: Text("Edit profile")) {
                        Text("👤 Edit profile")
                    }
                    NavigationLink(destination: Text("Security")) {
                        Text("🔐 Security")
                    }
                    NavigationLink(destination: Text("Notifications")) {
                        Text("🔔 Notifications")
                    }
                    NavigationLink(destination: Text("Privacy")) {
                        Text("🔒 Privacy")
                    }
                }
                Section(header: Text("Support & About").foregroundColor(.gray)) {
                    NavigationLink(destination: Text("My Subscription")) {
                        Text("💳 My Subscription")
                    }
                    NavigationLink(destination: Text("Help & Support")) {
                        Text("❓ Help & Support")
                    }
                    NavigationLink(destination: Text("Terms and Policies")) {
                        Text("📜 Terms and Policies")
                    }
                }
                Section(header: Text("Cache & cellular").foregroundColor(.gray)) {
                    NavigationLink(destination: Text("Free up space")) {
                        Text("🗑 Free up space")
                    }
                    NavigationLink(destination: Text("Data Saver")) {
                        Text("📱 Data Saver")
                    }
                }
                Section(header: Text("Actions").foregroundColor(.gray)) {
                    NavigationLink(destination: Text("Report a problem")) {
                        Text("🚨 Report a problem")
                    }
                    NavigationLink(destination: Text("Add account")) {
                        Text("➕ Add account")
                    }
                    Button(action: {
                        logout()
                    }) {
                        Text("🔓 Log out")
                    }
                    .foregroundColor(.red) 
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
            .background(Color.white)
            .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView()
            }
        }
    }

    private func logout() {
       
        isLoggedIn = false
        showLoginView.toggle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

