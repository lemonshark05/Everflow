//
//  ChatController.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import Foundation
import SwiftUI
import Combine

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
    
    func getAPIKey() -> String? {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
        }

        return nsDictionary?["OpenAI_API_Key"] as? String
    }
    
    func getAutoReply(inputText: String, completion: @escaping (String) -> Void) {
        guard let apiKey = getAPIKey() else {
            print("Failed to get API Key")
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
