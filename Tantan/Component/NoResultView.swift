//
//  NoResultView.swift
//  Tantan
//
//  Created by qinxinghua on 2024/12/29.
//

import SwiftUI

struct NoResultView: View {
    var body: some View {
        VStack {
            Image("User1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .overlay {
                    Circle()
                        .stroke(.accent,lineWidth: 10)
                }
                .clipShape(Circle())
                .shadow(radius: 1)
                .padding(.bottom, 40)
            Text("aaskdaksdklsakdkaskdlkasdlaksdjkaskdjkajskdjkasjdkajskdjkasjdkajskdjka")
                .foregroundStyle(.gray)
                .padding(.horizontal, 18)
            Button(action: {
                
            }, label: {
                Text("Edit Filter")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    NoResultView()
}
