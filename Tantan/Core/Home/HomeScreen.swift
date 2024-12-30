//
//  HomeScreen.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/25.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var appState: AppState
    var body: some View {
        if viewModel.hasMoreCard {
            ZStack {
                ForEach(viewModel.displayCard.reversed()) { card in
                    CardContainerView(viewModel: viewModel, card: card)
                        .environmentObject(appState)
                }
            }
        } else {
            NoResultView()
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(AppState())
}
