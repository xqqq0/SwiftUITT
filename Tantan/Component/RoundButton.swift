//
//  RoundButton.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/26.
//

import SwiftUI

enum ButtonType: String, CaseIterable, Identifiable {
    var id: RawValue {
        rawValue
    }
    case back = "gobackward"
    case no = "xmark"
    case heart = "heart.fill"
    case start = "star.fill"
}

struct RoundButton: View {
    var type: ButtonType
    var action: (() -> Void)?
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: type.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
                .colorButton(type: type)
                .background(.black.opacity(0.4))
        }
        .buttonStyle(PressButtonType())
    }
        
}


struct PressButtonType: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}

struct ColorButton: ViewModifier {
    var type: ButtonType
    func body(content: Content) -> some View {
        switch type {
        case .back:
            content.foregroundStyle(.yellow)
        case .no:
            content.foregroundStyle(.white)
                .padding(.horizontal, 30)
        case .heart:
            content.foregroundStyle(.pink)
                .padding(.horizontal, 30)
        case .start:
            content.foregroundStyle(.blue)
        }
    }
}

#Preview {
    VStack {
        ForEach(ButtonType.allCases) { type in
            RoundButton(type: type)
                .frame(height: 44)
        }
    }
}
