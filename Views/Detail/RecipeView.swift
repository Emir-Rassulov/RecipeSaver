//
//  RecipeView.swift
//  Food
//
//  Created by Emir Rassulov on 20/02/2024.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    if !recipe.description.isEmpty {
                        Text(recipe.description)
                            .multilineTextAlignment(.leading) 
                            .padding()
                    }
                    
                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Ingredients")
                                .font(.headline)
                            
                            Text(recipe.ingredients)
                                .padding(.horizontal)
                        }
                    }
                    
                    if !recipe.directions.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Directions")
                                .font(.headline)
                            
                            Text(recipe.directions)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: geometry.size.width)
            }
            .navigationBarTitle(recipe.name, displayMode: .inline)
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.all[0])
    }
}
