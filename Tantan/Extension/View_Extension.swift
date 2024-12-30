//
//  View_Extension.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/26.
//

import SwiftUI

extension View {
    func colorButton(type: ButtonType) -> some View {
        self.modifier(ColorButton(type: type))
    }
}
