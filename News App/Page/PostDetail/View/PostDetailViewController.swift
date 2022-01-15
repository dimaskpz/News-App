//
//  PostDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 14/01/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    @IBOutlet private var postDetailTableView: UITableView!

    var vm = PostDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        postDetailTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "PostTableViewCell")
        postDetailTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "CommentTableViewCell")
    }
}

extension PostDetailViewController: UITableViewDelegate {

}

extension PostDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.vm.comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let post = vm.postDisplay else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")
                    as? PostTableViewCell else { return UITableViewCell() }
            cell.setData(post: post)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell")
                    as? CommentTableViewCell else { return UITableViewCell() }
            let comment = vm.comments[indexPath.row]
            let name = comment.name
            let body = comment.body
            cell.commentLabel.text = "\(name) \(body)"
            cell.callbackUsernameTapped = { [weak self] in
                guard let self = self else { return }
                if let userData = self.vm.getUserSelected(email: comment.email) {
                    let userVC = UserDetailViewController()
                    let albumData = self.vm.getAlbumSelected(userId: userData.id)
                    userVC.vm.albums = albumData
                    userVC.vm.user = userData
                    userVC.vm.photos = self.vm.getPhotoSelected(albumData: albumData)
                    self.navigationController?.pushViewController(userVC, animated: true)
                }
                
            }
            return cell
        }
    }

}
