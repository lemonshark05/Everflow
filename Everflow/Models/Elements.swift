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

