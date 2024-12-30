//
//  CardContainerView.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/26.
//

import SwiftUI

struct CardContainerView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var appState: AppState
    var card: UserCard
    var body: some View {
        if appState.isFullScreen {
            CardDetailView(card: card)
        } else {
            ZStack(alignment: .bottom) {
                ForEach(viewModel.displayCard.reversed()) { card in
                    UserCardView(userCard: card) {
                        viewModel.nextUserCard()
                    }
                    .environmentObject(appState)
                }
                if viewModel.hasMoreCard {
                    HStack {
                        ForEach(ButtonType.allCases) { type in
                            RoundButton(type: type, action: {
                                switch type {
                                case .back:
                                    print("back")
                                case .no:
                                    viewModel.nextUserCard()
                                case .heart:
                                    viewModel.nextUserCard()
                                case .start:
                                    print("")
                                }
                            })
                                .frame(height: 44)
                        }
                    }
                    .padding(.bottom, 15)
                }
            }
        }
        
    }
}

#Preview {
    CardContainerView(viewModel: HomeViewModel(), card: UserCard(name: "DUDU", age: 29, place: "TJ", zodiac: "铁锤座", photos: ["User1"]))
        .environmentObject(AppState())
}
