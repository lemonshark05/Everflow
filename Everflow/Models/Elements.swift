//
//  Elements.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import Foundation

struct Information: Identifiable {
    let id = UUID()
    let sender: String
    let infoType: InfoType
    let isCurrentUser: Bool
}

enum InfoType {
    case text(String)
    case table([String])
}

struct ChatBox {
    let id:Int // Add a unique identifier
    let username: String
    let content: String
}

public struct ChatMessage: Codable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case role, content
    }

    /// ID used for iterating through list of chat messages
    public var id = UUID().uuidString

    /// The person sending the message
    public let role: ChatRole

    /// The message itself
    public let content: String

    public init(role: ChatRole, content: String) {
        self.role = role
        self.content = content
    }

    public var body: [String: String] {
        return [
            "role": self.role.rawValue,
            "content": self.content
        ]
    }
}

public enum ChatRole: String, Codable {
    /// The context of the chat
    case system

    /// The main user chatting
    case user

    /// The main AI chatting
    case assistant
}
