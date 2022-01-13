//
//  PostTableViewCell.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
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
    
}
