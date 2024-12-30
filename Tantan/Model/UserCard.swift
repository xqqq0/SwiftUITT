//
//  UserCard.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/25.
//

import Foundation

struct UserCard: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let place: String
    let zodiac: String
    let photos: [String]
}
