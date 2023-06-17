//
//  ChatView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct ChatView: View {
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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
