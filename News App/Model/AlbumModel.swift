//
//  AlbumModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation


// MARK: - WelcomeElement
struct AlbumElement: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias Albums = [AlbumElement]
