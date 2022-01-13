//
//  CommentModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

// MARK: - WelcomeElement
struct CommentElement: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Comments = [CommentElement]
