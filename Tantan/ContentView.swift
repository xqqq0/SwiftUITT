//
//  ContentView.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appState: AppState = AppState()
    
    var body: some View {
        VStack {
            switch appState.selectTab {
            case .home:
                HomeScreen()
                    .environmentObject(appState)
            case .live:
                Text("live")
            case .message:
                Text("message")
            case .profile:
                Text("profile")
            }
            if !appState.isFullScreen {
                Spacer()
                HStack {
                    createTabBarItem(tab: .home, title: "home")
                    createTabBarItem(tab: .live, title: "live")
                    createTabBarItem(tab: .message, title: "message")
                    createTabBarItem(tab: .profile, title: "profile")
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 50)
    }
    
    func createTabBarItem(tab: TabItem, title: String) -> some View {
        return Button {
            appState.selectTab = tab
        } label: {
            let isSelect = tab == appState.selectTab
            let color = isSelect ? Color.accent : .gray
            VStack {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(color)
                    .frame(maxWidth: .infinity)
                Text(title)
                    .font(.system(size: 10))
                    .foregroundStyle(color)
                
            }
        }
    }
}

struct TabBarItem: Hashable {
    let title: String
    let icon: String
}

enum TabItem: String {
    case home = "rectangle.fill.on.rectangle.fill"
    case live = "play.tv.fill"
    case message = "message.fill"
    case profile = "person.fill"
}
#Preview {
    ContentView()
}
