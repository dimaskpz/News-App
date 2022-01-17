//
//  PostTableViewCell.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    var callbackUsername: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.setRoundedCorner(8)
//        cardView.tintColor = .red
//        cardView.backgroundColor = .blue
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor.lineColor.cgColor

        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds      = true
        cardView.backgroundColor = UIColor.white
        
        selectionStyle = .none
        let tap = UITapGestureRecognizer(target: self, action: #selector(usernameTapped))
        usernameLabel.addGestureRecognizer(tap)
        usernameLabel.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(post: PostDisplay) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
        usernameLabel.text = post.username
        companyLabel.text = " - \(post.companyName)"
    }

    @objc private
      func usernameTapped() {
          callbackUsername?()
      }
    
}
