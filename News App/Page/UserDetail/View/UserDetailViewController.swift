//
//  UserDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var albumCollectionView: UICollectionView!

    var vm = UserDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "AlbumCollectionViewCell")

        albumCollectionView.register(UINib(nibName: "HeaderAlbumCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HeaderAlbumCollectionReusableView")
        albumCollectionView.dataSource = self
        albumCollectionView.delegate = self
    }
}

extension UserDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.albums.count
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let album = vm.albums[section]
        let photos: [PhotoElement] = vm.photos.filter({ $0.albumID == album.id })
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell else { return .init() }
        let album = vm.albums[indexPath.section]
        let photos: [PhotoElement] = vm.photos.filter({ $0.albumID == album.id })
        cell.setImage(string: photos[indexPath.row].thumbnailURL)
        cell.albumLabel.text = photos[indexPath.row].title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderAlbumCollectionReusableView", for: indexPath) as! HeaderAlbumCollectionReusableView
        sectionHeader.titleLabel.text = vm.albums[indexPath.row].title
        return sectionHeader
    }

}

extension UserDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoDetailViewController()
        photoVC.vm.photos = self.vm.photos// seharusnya selected album
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}
