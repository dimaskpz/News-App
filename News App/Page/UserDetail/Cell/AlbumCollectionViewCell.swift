//
//  AlbumCollectionViewCell.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setImage(string: String) {
        guard let url = URL(string: string) else { return }
        albumImage.kf.setImage(with: url)
    }
}
