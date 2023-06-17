//
//  ChatRow.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct ChatRow: View {
    let info: Information

    var body: some View {
        HStack {
            if info.isCurrentUser {
                Spacer()
            }

            VStack(alignment: .leading) {
                Text(info.sender)
                    .font(.caption)
                    .foregroundColor(info.isCurrentUser ? .white : .gray)

                switch info.infoType {
                case .text(let content):
                    Text(content)
                        .padding(10)
                        .background(info.isCurrentUser ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
//                case .image(let image):
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200)
//                        .cornerRadius(10)
                case .table(let data):
                    VStack {
                        ForEach(data, id: \.self) { item in
                            Text(item)
                                .padding(5)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                }
            }

            if !info.isCurrentUser {
                Spacer()
            }
        }
    }
}

