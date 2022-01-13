//
//  TodoModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

// MARK: - WelcomeElement
struct TodoElement: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias Todos = [TodoElement]
