//
//  Home.swift
//  Food
//
//  Created by Emir Rassulov on 27/02/2024.


//import SwiftUI
//
//struct Home: View {
//
//   @State private var activeTab: Tab = .home
//
//    @Namespace private var animation
//    @State private var tabShapePosition: CGPoint = .zero
//    init() {
//
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .clear
//
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//        UITabBar.appearance().isHidden = true
//        UITabBar.appearance().barTintColor = .clear
//    }
//    var body: some View {
//        VStack(spacing: 0) {
//
//            TabView(selection: $activeTab) {
//
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(Tab.home)
//
//                CategoriesView()
//                    .tabItem {
//                        Label("Categories", systemImage: "square.fill.text.grid.1x2")
//                    }
//                    .tag(Tab.categories)
//
//                NewRecipeView()
//                    .tabItem {
//                        Label("New", systemImage: "plus")
//                    }
//                    .tag(Tab.new)
//
//                FavoritesView()
//                    .tabItem {
//                        Label("Favorites", systemImage: "heart")
//                    }
//                    .tag(Tab.favorites)
//
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gear")
//                    }
//                    .tag(Tab.settings)
//            }
//
//            CustomTabBar()
//        }
//    }
//
//    @ViewBuilder
//    func CustomTabBar(_ tint: Color = Color("blue"), _ inactiveTint: Color = .blue) -> some View {
//        HStack(alignment: .bottom, spacing: 0) {
//            ForEach(Tab.allCases, id: \.rawValue) {
//                TabItem(
//                    tint: tint,
//                    inactiveTint: inactiveTint,
//                    tab: $0,
//                    animation: animation,
//                    activeTab: $activeTab,
//                    position: $tabShapePosition
//                )
//            }
//        }
//        .padding(.horizontal, 15)
//        .padding(.vertical, 10)
//        .background(content: {
//            TabShape(midpoint: tabShapePosition.x)
//                .fill(.white)
//                .ignoresSafeArea()
//                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: -5)
//
//        })
//        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
//    }
//}
//
//
//struct TabItem: View {
//    var tint: Color
//    var inactiveTint: Color
//    var tab: Tab
//    var animation: Namespace.ID
//    @Binding var activeTab: Tab
//    @Binding var position: CGPoint
//
//    /// Each Tab Item Position on the Screen
//    @State private var tabPosition: CGPoint = .zero
//    var body: some View {
//        VStack(spacing: 5) {
//            Image(systemName: tab.systemImage)
//                .font(.title2)
//                .foregroundColor(activeTab == tab ? .white : inactiveTint)
//                /// Increasing Size for the Active Tab
//                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
//                .background {
//                    if activeTab == tab {
//                        Circle()
////                            .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
////                           .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
//                            .fill(LinearGradient(gradient: .init(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing))
//
//                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                    }
//                }
//
//            Text(tab.rawValue)
//                .font(.caption)
//                .foregroundColor(activeTab == tab ? tint : .gray)
//        }
//        .frame(maxWidth: .infinity)
//        .contentShape(Rectangle())
//        .viewPosition(completion: { rect in
//            tabPosition.x = rect.midX
//
//            /// Updating Active Tab Position
//            if activeTab == tab {
//                position.x = rect.midX
//            }
//        })
//        .onTapGesture {
//            activeTab = tab
//
//            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                position.x = tabPosition.x
//            }
//        }
//    }
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Home()
//                .preferredColorScheme(.dark)
//                .environmentObject(RecipesViewModel())
//        }
//    }
//}



//import SwiftUI
//
//struct Home: View {
//    @State private var activeTab: Tab = .home
//    @Namespace private var animation
//    @State private var tabShapePosition: CGPoint = .zero
//
//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .clear
//
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//        UITabBar.appearance().isHidden = true
//        UITabBar.appearance().barTintColor = .clear
//    }
//
//    var body: some View {
//        VStack(spacing: 0) {
//            TabView(selection: $activeTab) {
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(Tab.home)
//
//                CategoriesView()
//                    .tabItem {
//                        Label("Categories", systemImage: "square.fill.text.grid.1x2")
//                    }
//                    .tag(Tab.categories)
//
//                NewRecipeView()
//                    .tabItem {
//                        Label("New", systemImage: "plus")
//                    }
//                    .tag(Tab.new)
//
//                FavoritesView()
//                    .tabItem {
//                        Label("Favorites", systemImage: "heart")
//                    }
//                    .tag(Tab.favorites)
//
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gear")
//                    }
//                    .tag(Tab.settings)
//            }
//
//            CustomTabBar()
//        }
//    }
//
//    @ViewBuilder
//    func CustomTabBar(_ tint: Color = Color("blue"), _ inactiveTint: Color = .blue) -> some View {
//        HStack(alignment: .bottom, spacing: 0) {
//            ForEach(Tab.allCases, id: \.rawValue) {
//                TabItem(
//                    tint: tint,
//                    inactiveTint: inactiveTint,
//                    tab: $0,
//                    animation: animation,
//                    activeTab: $activeTab,
//                    position: $tabShapePosition
//                )
//            }
//        }
//        .padding(.horizontal, 15)
//        .padding(.vertical, 10)
//        .background(content: {
//            TabShape(midpoint: tabShapePosition.x)
//                .fill(Color(UIColor.systemBackground)) // Use system background color for light and dark mode
//                .ignoresSafeArea()
//                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: -5)
//        })
//        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
//    }
//}
//
//struct TabItem: View {
//    var tint: Color
//    var inactiveTint: Color
//    var tab: Tab
//    var animation: Namespace.ID
//    @Binding var activeTab: Tab
//    @Binding var position: CGPoint
//    @State private var tabPosition: CGPoint = .zero
//
//    var body: some View {
//        VStack(spacing: 5) {
//            Image(systemName: tab.systemImage)
//                .font(.title2)
//                .foregroundColor(activeTab == tab ? .white : inactiveTint)
//                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
//                .background {
//                    if activeTab == tab {
//                        Circle()
//                            .fill(LinearGradient(gradient: Gradient(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing))
//                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                    }
//                }
//
//            Text(tab.rawValue)
//                .font(.caption)
//                .foregroundColor(activeTab == tab ? tint : .gray)
//        }
//        .frame(maxWidth: .infinity)
//        .contentShape(Rectangle())
//        .viewPosition(completion: { rect in
//            tabPosition.x = rect.midX
//
//            if activeTab == tab {
//                position.x = rect.midX
//            }
//        })
//        .onTapGesture {
//            activeTab = tab
//
//            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                position.x = tabPosition.x
//            }
//        }
//    }
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Home()
//                .preferredColorScheme(.dark)
//                .environmentObject(RecipesViewModel())
//        }
//    }
//}

//import SwiftUI
//
//struct Home: View {
//    @State private var activeTab: Tab = .home
//    @Namespace private var animation
//    @State private var tabShapePosition: CGPoint = .zero
//
//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .clear
//
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//        UITabBar.appearance().isHidden = true
//        UITabBar.appearance().barTintColor = .clear
//    }
//
//    var body: some View {
//        VStack(spacing: 0) {
//            TabView(selection: $activeTab) {
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(Tab.home)
//
//                CategoriesView()
//                    .tabItem {
//                        Label("Categories", systemImage: "square.fill.text.grid.1x2")
//                    }
//                    .tag(Tab.categories)
//
//                NewRecipeView()
//                    .tabItem {
//                        Label("New", systemImage: "plus")
//                    }
//                    .tag(Tab.new)
//
//                FavoritesView()
//                    .tabItem {
//                        Label("Favorites", systemImage: "heart")
//                    }
//                    .tag(Tab.favorites)
//
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gear")
//                    }
//                    .tag(Tab.settings)
//            }
//
//            CustomTabBar()
//        }
//    }
//
//    @ViewBuilder
//    func CustomTabBar(_ tint: Color = Color("blue"), _ inactiveTint: Color = .blue) -> some View {
//        HStack(alignment: .bottom, spacing: 0) {
//            ForEach(Tab.allCases, id: \.rawValue) {
//                TabItem(
//                    tint: tint,
//                    inactiveTint: inactiveTint,
//                    tab: $0,
//                    animation: animation,
//                    activeTab: $activeTab,
//                    position: $tabShapePosition
//                )
//            }
//        }
//        .padding(.horizontal, 15)
//        .padding(.vertical, 10)
//        .background(content: {
//            TabShape(midpoint: tabShapePosition.x)
//                .fill(Color(UIColor.systemBackground))
//                .ignoresSafeArea()
//                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: -5)
//        })
//        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
//    }
//}
//
//struct TabItem: View {
//    var tint: Color
//    var inactiveTint: Color
//    var tab: Tab
//    var animation: Namespace.ID
//    @Binding var activeTab: Tab
//    @Binding var position: CGPoint
//    @State private var tabPosition: CGPoint = .zero
//
//    var body: some View {
//        VStack(spacing: 5) {
//            Image(systemName: tab.systemImage)
//                .font(.title2)
//                .foregroundColor(activeTab == tab ? .white : inactiveTint)
//                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
//                .background {
//                    if activeTab == tab {
//                        Circle()
//                            .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
//                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                    }
//                }
//
//            Text(tab.rawValue)
//                .font(.caption)
//                .foregroundColor(activeTab == tab ? tint : .gray)
//        }
//        .frame(maxWidth: .infinity)
//        .contentShape(Rectangle())
//        .viewPosition(completion: { rect in
//            tabPosition.x = rect.midX
//
//            if activeTab == tab {
//                position.x = rect.midX
//            }
//        })
//        .onTapGesture {
//            activeTab = tab
//
//            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                position.x = tabPosition.x
//            }
//        }
//    }
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Home()
//                .preferredColorScheme(.dark)
//                .environmentObject(RecipesViewModel())
//        }
//    }
//}

import SwiftUI



struct Home: View {
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isHidden = true
        UITabBar.appearance().barTintColor = .clear
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tab.home)

                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "square.fill.text.grid.1x2")
                    }
                    .tag(Tab.categories)

                NewRecipeView()
                    .tabItem {
                        Label("New", systemImage: "plus")
                    }
                    .tag(Tab.new)

                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
                    .tag(Tab.favorites)

                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(Tab.settings)
            }

            CustomTabBar()
        }
    }

    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(Color(UIColor.systemBackground))
                .ignoresSafeArea()
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: -5)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    @State private var tabPosition: CGPoint = .zero

    private var colorScheme: ColorScheme {
        return UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
    }

    private func getCircleGradient() -> LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color("primary2"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
        }
    }

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(getCircleGradient())
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }

            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX

            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .preferredColorScheme(.dark)
                .environmentObject(RecipesViewModel())
        }
    }
}
