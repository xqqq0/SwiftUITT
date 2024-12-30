//
//  AppState.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/23.
//

import Foundation

class AppState: ObservableObject {
    @Published var selectTab: TabItem
    @Published var isFullScreen: Bool
    @Published var isPremium: Bool
    init(selectTab: TabItem = .home, isFullScreen: Bool = false, isPremium: Bool = false) {
        self.selectTab = selectTab
        self.isFullScreen = isFullScreen
        self.isPremium = isPremium
    }
}
