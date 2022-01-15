//
//  PostViewController.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import UIKit

final class PostViewController: UIViewController {
    @IBOutlet private var postTableView: UITableView!

    var postVM = PostViewModel()

    var isUserDone = false
    var isPostDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Social Media"
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "PostTableViewCell")

        postVM.getPosts(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                self.isPostDone = true
                if self.isUserDone {
                    self.postVM.getSetupPostView()
                    self.postTableView.reloadData()
                }
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        postVM.getUserData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                self.isUserDone = true
                if self.isPostDone {
                    self.postVM.getSetupPostView()
                    self.postTableView.reloadData()
                }
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        postVM.getCommentData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                // do nothing
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        postVM.getAlbumData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                // do nothing
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        postVM.getPhotoData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                // do nothing
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = self.postVM.postDisplay[indexPath.row]
        let postDetailVC = PostDetailViewController()
        postDetailVC.postDetailVM.postDisplay = selectedPost
        postDetailVC.postDetailVM.comments = self.postVM.getCommentSelected(idPost: selectedPost.postId)
        postDetailVC.postDetailVM.users = self.postVM.users
        postDetailVC.postDetailVM.photos = self.postVM.photos
        postDetailVC.postDetailVM.albums = self.postVM.albums

        self.navigationItem.backButtonTitle = "Post Detail"
        self.navigationController?.pushViewController(postDetailVC, animated: true)
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postVM.postDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")
                as? PostTableViewCell else { return UITableViewCell() }
        let post = postVM.postDisplay[indexPath.row]
        cell.setData(post: post)
        cell.callbackUsername = { [weak self] in
            guard let self = self else { return }
            if let userData = self.postVM.getUserSelected(userId: post.userId) {
                let userVC = UserDetailViewController()
                let albumData = self.postVM.getAlbumSelected(userId: userData.id)
                userVC.userDetailVM.albums = albumData
                userVC.userDetailVM.user = userData
                userVC.userDetailVM.photos = self.postVM.getPhotoSelected(albumData: albumData)
                self.navigationItem.backButtonTitle = "User Detail"
                self.navigationController?.pushViewController(userVC, animated: true)
            }
        }
        return cell
    }
}
