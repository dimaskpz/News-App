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
