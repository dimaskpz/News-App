//
//  PhotoModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

// MARK: - WelcomeElement
struct PhotoElement: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Photos = [PhotoElement]
