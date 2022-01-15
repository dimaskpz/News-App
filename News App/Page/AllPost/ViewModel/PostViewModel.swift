//
//  PostViewModel.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

class PostViewModel {

    var posts: Posts = []
    var postService = PostService.shared

    var users: [UserElement] = []
    var userService = UserService.shared

    var postDisplay: [PostDisplay] = []

    func getPosts(completion: @escaping ((_ statusCode: Int?, ErrorMapping?) -> Void) ) {
        let param = "/posts"
        postService.getPostDataFromServer(parameters: param, completion: { [weak self] data, error in
            if let _ = error {
                completion(nil, error)
                return
            }
            guard let self = self, let data = data else { return }
            self.posts = data
            completion(200, nil)
        })
    }

    func getUserData(completion: @escaping ((_ statusCode: Int?, ErrorMapping?) -> Void) ) {
        let param = "/users"
        userService.getUsersDataFromServer(parameters: param, completion: { [weak self] data, error in
            if let _ = error {
                completion(nil, error)
                return
            }
            guard let self = self, let data = data else { return }
            self.users = data
            completion(200, nil)
        })
    }

    func getSetupPostView() {
        var postDisplayLocal: [PostDisplay] = []
        for post in posts {
            if let user = users.first(where: { $0.id == post.id }) {
                let display = PostDisplay(post: post, user: user)
                postDisplayLocal.append(display)
            }
        }
        postDisplay = postDisplayLocal
    }

    var commentService = CommentService.shared
    var comments: [CommentElement] = []

    func getCommentData(completion: @escaping ((_ statusCode: Int?, ErrorMapping?) -> Void) ) {
        let param = "/comments"
        commentService.getDataFromServer(parameters: param, completion: { [weak self] data, error in
            if let _ = error {
                completion(nil, error)
                return
            }
            guard let self = self, let data = data else { return }
            self.comments = data
            completion(200, nil)
        })
    }

    var albumService = AlbumService.shared
    var albums: Albums = []

    func getAlbumData(completion: @escaping ((_ statusCode: Int?, ErrorMapping?) -> Void) ) {
        let param = "/albums"
        albumService.getDataFromServer(parameters: param, completion: { [weak self] data, error in
            if let _ = error {
                completion(nil, error)
                return
            }
            guard let self = self, let data = data else { return }
            self.albums = data
            completion(200, nil)
        })
    }

    var photoService = PhotoService.shared
    var photos: [PhotoElement] = []

    func getPhotoData(completion: @escaping ((_ statusCode: Int?, ErrorMapping?) -> Void) ) {
        let param = "/photos"
        photoService.getDataFromServer(parameters: param, completion: { [weak self] data, error in
            if let _ = error {
                completion(nil, error)
                return
            }
            guard let self = self, let data = data else { return }
            self.photos = data
            completion(200, nil)
        })
    }

}

extension PostViewModel {
    func getCommentSelected(idPost: Int) -> [CommentElement] {
        return self.comments.filter({ $0.postID == idPost })
    }
}

extension PostViewModel {
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

struct PostDisplay {
    let userId: Int
    let postId: Int
    let body: String
    let title: String
    let username: String
    let companyName: String

    init(post: PostElement, user: UserElement) {
        self.userId = user.id
        self.username = user.username
        self.companyName = user.company.name
        self.postId = post.id
        self.title = post.title
        self.body = post.body
    }
}
