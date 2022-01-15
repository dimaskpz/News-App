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

    var userDetailVM = UserDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        albumCollectionView.dataSource = self
        albumCollectionView.delegate = self
        albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCollectionViewCell")
        albumCollectionView.register(UINib(nibName: "HeaderAlbumCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderAlbumCollectionReusableView")

        let layout = albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true

    }
}

extension UserDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return userDetailVM.albums.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let album = userDetailVM.albums[section]
        let photos: [PhotoElement] = userDetailVM.photos.filter({ $0.albumID == album.id })
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell else { return .init() }
        let album = userDetailVM.albums[indexPath.section]
        let photos: [PhotoElement] = userDetailVM.photos.filter({ $0.albumID == album.id })
        cell.albumImage.setImage(string: photos[indexPath.row].thumbnailURL)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderAlbumCollectionReusableView", for: indexPath) as? HeaderAlbumCollectionReusableView else { return UICollectionReusableView() }
        sectionHeader.titleLabel.text = userDetailVM.albums[indexPath.section].title
        return sectionHeader
    }
}

extension UserDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoDetailViewController()
        let album = userDetailVM.albums[indexPath.section]
        let photos: [PhotoElement] = userDetailVM.photos.filter({ $0.albumID == album.id })
        photoVC.photoDetailVM.photos = photos
        photoVC.photoDetailVM.selectedIndex = indexPath.row
        self.navigationItem.backButtonTitle = album.title
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}

extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width / 5) - 10
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
