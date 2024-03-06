//
//  Tab.swift
//  Custom  Tab Bar
//
//  Created by Emir Rassulov on 27/02/2024.
//

import SwiftUI

// App Tab's

enum Tab: String, CaseIterable {
    case home = "Home"
    case categories = "Categories"
    case new = "New"
    case favorites = "Favorites"
    case settings = "Settings"

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .categories:
            return "square.fill.text.grid.1x2"
        case .new:
            return "plus"
        case .favorites:
            return "heart"
        case .settings:
            return "gear"
        }
    }

    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

