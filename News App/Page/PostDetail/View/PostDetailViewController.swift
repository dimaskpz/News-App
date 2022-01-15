//
//  PostDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 14/01/22.
//

import UIKit

final class PostDetailViewController: UIViewController {
    @IBOutlet private var postDetailTableView: UITableView!

    var postDetailVM = PostDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        postDetailTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "PostTableViewCell")
        postDetailTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "CommentTableViewCell")
//        postDetailTableView.separatorStyle = .none
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
            return self.postDetailVM.comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let post = postDetailVM.postDisplay else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")
                    as? PostTableViewCell else { return UITableViewCell() }
            cell.setData(post: post)
            cell.callbackUsername = { [weak self] in
                guard let self = self else { return }
                if let userData = self.postDetailVM.getUserSelected(userId: post.userId) {
                    let userVC = UserDetailViewController()
                    let albumData = self.postDetailVM.getAlbumSelected(userId: userData.id)
                    userVC.userDetailVM.albums = albumData
                    userVC.userDetailVM.user = userData
                    userVC.userDetailVM.photos = self.postDetailVM.getPhotoSelected(albumData: albumData)
                    self.navigationItem.backButtonTitle = "User Detail"
                    self.navigationController?.pushViewController(userVC, animated: true)
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell")
                    as? CommentTableViewCell else { return UITableViewCell() }
            let comment = postDetailVM.comments[indexPath.row]
            let name = comment.name
            let body = comment.body
            cell.usernameLabel.text = name
            cell.commentLabel.text = body
            return cell
        }
    }
//
//    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1 {
//            let view = UIView()
//            view.backgroundColor = UIColor.gray
//            return view
//        } else { return nil }
//   }
//
//   public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//       if section == 1 {
//           return 1
//       } else {
//           return 0
//       }
//   }

}
