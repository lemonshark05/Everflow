//
//  ChatController.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import Foundation
import SwiftUI
import Combine
import OpenAIKit
import NIO
import AsyncHTTPClient

class ChatController: ObservableObject {
    @Published var infos: [Information] = []

    func sendMessage(inputText: String) {
        if !inputText.isEmpty {
            let newMessage = Information(sender: "User", infoType: .text(inputText), isCurrentUser: true)
            infos.append(newMessage)

            // Get auto-reply from ChatGPT API
            getAutoReply(inputText: inputText) { autoReply in
                let messageType: InfoType
                if autoReply.lowercased().contains("table") {
                    messageType = .table(["Column 1", "Column 2", "Column 3"])
                } else {
                    messageType = .text("\(autoReply)")
                }

                let replyMessage = Information(sender: "ChatGPT", infoType: messageType, isCurrentUser: false)
                self.infos.append(replyMessage)
            }
        }
    }

//    func getAutoReply(inputText: String, completion: @escaping (String) -> Void) {
//        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
//            print("Failed to get API Key")
//            return
//        }
//        guard let organization = ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"] else {
//            print("Failed to get Organization")
//            return
//        }
//
//        let urlSession = URLSession(configuration: .default)
//        let configuration = Configuration(apiKey: apiKey, organization: organization)
//        let openAIClient = OpenAIKit.Client(session: urlSession, configuration: configuration)
//
//        Task {
//            do {
//                let response = try await openAIClient.chats.create(
//                    model: Model.GPT3.davinci,
//                    messages: [
//                        ChatMessage(role: .system, content: "You are talking to ChatGPT"),
//                        ChatMessage(role: .user, content: inputText)
//                    ]
//                )
//                // Get the content of the last message from the API response, which should be the bot's reply
//                if let botReply = response.messages.last?.content {
//                    DispatchQueue.main.async {
//                        completion(botReply.trimmingCharacters(in: .whitespacesAndNewlines))
//                    }
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }

    func getAutoReply(inputText: String, completion: @escaping (String) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
            print("Failed to get API Key")
            return
        }
        guard let organization = ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"] else {
            print("Failed to get Organization")
            return
        }
        let api = ChatGPTAPI(apiKey: apiKey)
        Task {
            do {
                let response = try await api.sendMessage(text: inputText)
                // Call completion handler with response text
                DispatchQueue.main.async {
                    completion(response.trimmingCharacters(in: .whitespacesAndNewlines))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
