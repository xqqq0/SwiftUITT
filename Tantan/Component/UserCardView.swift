//
//  UserCardView.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/25.
//

import SwiftUI

struct UserCardView: View {
    var userCard:UserCard
    var swipeAction: (()->Void)?
    @EnvironmentObject var appState: AppState
    @State var imageIndex: Int = 0
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader(content: { geometry in
            let frameWidth = geometry.size.width
            let frameHeight = geometry.size.height
            ZStack(alignment: .top) {
                Image(userCard.photos[imageIndex])
                    .resizable()
                    .frame(width: frameWidth, height: frameHeight)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: appState.isFullScreen ? 0 : 20))
                // 点击左右切换的按钮
                HStack {
                    Rectangle()
                        .onTapGesture {
                            updateItemIndex(hasMore: false)
                        }
                    Rectangle()
                        .onTapGesture {
                            updateItemIndex(hasMore: true)
                        }
                }
                .foregroundStyle(.white.opacity(0.01))
                // 图片
                HStack {
                    ForEach(0..<userCard.photos.count, id:\.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 4)
                            .foregroundStyle(imageIndex == index ? .white : .gray.opacity(0.5) )
                    }
                }
                .padding(10)
                .padding(.horizontal)
                // 拖动时显示的标签
                if !appState.isFullScreen {
                    VStack {
                        HStack {
                            if offset.width > 0 {
                                createUserCardLabel(title: "喜欢", degree: -20, color: .red)
                                Spacer()
                            } else if offset.width < 0 {
                                Spacer()
                                createUserCardLabel(title: "拒绝", degree: 20, color: .green)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        Spacer()
                        createUserCardBottomInfo()
                    }
                }
            }
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .rotationEffect(getRotateAmount())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if !appState.isFullScreen {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                offset = value.translation
                            }
                        }
                    })
                    .onEnded({ value in
                        if !appState.isFullScreen {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                // 超过一半的80%
                                let maxDragOffset = frameWidth * 0.5 * 0.8
                                let dragOffset = value.translation.width
                                let checkGragStatus = abs(dragOffset)
                                if checkGragStatus > maxDragOffset {
                                    offset = CGSize(width: (dragOffset > 0 ? frameWidth : -frameWidth) * 5, height: value.translation.height)
                                    swipeAction?()
                                } else {
                                    offset = .zero
                                }
                            }
                        }
                    })
            )
        })
    }
    
    func updateItemIndex(hasMore: Bool) {
        let nextInde = hasMore ? imageIndex + 1 : imageIndex - 1
        imageIndex = min(max(0, nextInde), userCard.photos.count - 1)
    }
    
    func getScaleAmount() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width * 0.5
        let amount = abs(offset.width)
        let percentage = amount / maxWidth
        return 1 - min(percentage, 0.7) * 0.3
    }
    
    func getRotateAmount() -> Angle {
        let maxWidth = UIScreen.main.bounds.width * 0.5
        let amount = offset.width
        let percentage = amount / maxWidth
        let value = Double(percentage * 10)
        return Angle(degrees: value)
    }
    
    func createUserCardLabel(title: String, degree: Double, color: Color) -> some View {
        Text(title)
            .tracking(3)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundStyle(color)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 3)
            }
            .rotationEffect(.degrees(degree))
    }
    
    func createUserCardBottomInfo() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(userCard.name), \(userCard.age)")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                HStack {
                    Text(userCard.zodiac)
                        .fontWeight(.bold)
                        .padding(5)
                        .background(.white.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    Text(userCard.place)
                }
            }
            Spacer()
            Button {
                appState.isFullScreen = true
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 30))
                    .padding(8)
            }
        }
        .foregroundStyle(.white)
        .padding(.bottom, 80)
        .background(
            LinearGradient(colors: [.black.opacity(0.9), .clear], startPoint: .bottom, endPoint: .top)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .clipped()
    }
}

#Preview {
    UserCardView(userCard: UserCard(name: "songyi", age: 18, place: "老家", zodiac: "水泥坐", photos: ["User4", "User5"]))
        .environmentObject(AppState(isFullScreen: false))
}
