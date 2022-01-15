//
//  CommentTableViewCell.swift
//  News App
//
//  Created by dimas pratama on 14/01/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    var callbackUsernameTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        let tap = UITapGestureRecognizer(target: self, action: #selector(usernameTapped))
        usernameLabel.addGestureRecognizer(tap)
        usernameLabel.isUserInteractionEnabled = true
    }

    @objc private
      func usernameTapped() {
          callbackUsernameTapped?()
      }

}
