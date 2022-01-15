//
//  PostDetailViewModel.swift
//  News App
//
//  Created by dimas pratama on 14/01/22.
//

import Foundation

final class PostDetailViewModel {

    var postDisplay: PostDisplay?
    var comments: [CommentElement] = []

    // data for next page (user page)
    var users: [UserElement] = []
    var photos: [PhotoElement] = []
    var albums: [AlbumElement] = []

    func getAlbumSelected(userId: Int) -> [AlbumElement] {
        return albums.filter({ $0.userID == userId })
    }

    func getPhotoSelected(albumData: [AlbumElement]) -> [PhotoElement] {
        var photoData: [PhotoElement] = []
        for album in albumData {
            let tempData: [PhotoElement] = photos.filter({ $0.albumID == album.id })
            photoData.append(contentsOf: tempData)
        }
        return photoData
    }

    func getUserSelected(userId: Int) -> UserElement? {
        return users.first(where: { $0.id == userId })
    }
    
}
