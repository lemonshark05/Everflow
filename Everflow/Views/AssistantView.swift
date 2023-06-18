//
//  AssistantView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct AssistantView: View {
    @ObservedObject var chatController = ChatController()
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            // Chat messages
            List(chatController.infos) { info in
                ChatRow(info: info)
            }
            
            // Input field and send button
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    chatController.sendMessage(inputText: inputText)
                    inputText = ""
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }.padding(.trailing)
            }
        }
    }
}

struct AssistantView_Previews: PreviewProvider {
    static var previews: some View {
        AssistantView()
    }
}

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
