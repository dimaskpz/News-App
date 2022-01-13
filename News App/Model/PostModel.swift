//
//  PostModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

// MARK: - WelcomeElement
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [Post]
