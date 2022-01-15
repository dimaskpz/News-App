//
//  PostViewController.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import UIKit

final class PostViewController: UIViewController {
    @IBOutlet private var postTableView: UITableView!

    var vm = PostViewModel()

    var isUserDone = false
    var isPostDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Social Media"
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "PostTableViewCell")

        vm.getPosts(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                self.isPostDone = true
                if self.isUserDone {
                    self.vm.getSetupPostView()
                    self.postTableView.reloadData()
                }
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        vm.getUserData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                self.isUserDone = true
                if self.isPostDone {
                    self.vm.getSetupPostView()
                    self.postTableView.reloadData()
                }
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        vm.getCommentData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                // do nothing
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        vm.getAlbumData(completion: { [weak self] statusCode, errorMap in
            guard let self = self else { return }
            if statusCode == 200 {
                // do nothing
            } else {
                showMessage(vc: self, text: errorMap?.message)
            }
        })

        vm.getPhotoData(completion: { [weak self] statusCode, errorMap in
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
        let selectedPost = self.vm.postDisplay[indexPath.row]
        let postDetailVC = PostDetailViewController()
        postDetailVC.vm.postDisplay = selectedPost
        postDetailVC.vm.comments = self.vm.getCommentSelected(idPost: selectedPost.postId)
        postDetailVC.vm.users = self.vm.users
        postDetailVC.vm.photos = self.vm.photos
        postDetailVC.vm.albums = self.vm.albums
        self.navigationController?.pushViewController(postDetailVC, animated: true)
    }
}


extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.postDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")
                as? PostTableViewCell else { return UITableViewCell() }
        cell.setData(post: vm.postDisplay[indexPath.row])
        return cell

    }
}
