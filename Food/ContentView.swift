//
//  ContentView.swift
//  Food
//
//  Created by Emir Rassulov on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{

            OnboardingView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
