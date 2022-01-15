//
//  PhotoDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var photoDetailCollectionView: UICollectionView!

    var photoDetailVM = PhotoDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailCollectionView.delegate = self
        photoDetailCollectionView.dataSource = self
        photoDetailCollectionView.register(UINib(nibName: "PhotoDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoDetailCollectionViewCell")
        photoDetailCollectionView.collectionViewLayout = getLayout()
        photoDetailCollectionView.isPagingEnabled = true
        photoDetailCollectionView.isHidden = true
        titleLabel.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let rect = self.photoDetailCollectionView.layoutAttributesForItem(at:IndexPath(row: photoDetailVM.selectedIndex, section: 0))?.frame
        self.photoDetailCollectionView.scrollRectToVisible(rect!, animated: false)
        photoDetailCollectionView.isHidden = false
        titleLabel.isHidden = false
    }

    private func getLayout() -> UICollectionViewLayout {
        let width: CGFloat = (photoDetailCollectionView.frame.size.width)
        let height: CGFloat = (photoDetailCollectionView.frame.size.height)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: 0,
                                           right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }
}

extension PhotoDetailViewController: UICollectionViewDelegate { }

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDetailVM.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoDetailCollectionViewCell", for: indexPath) as? PhotoDetailCollectionViewCell else { return .init() }
        let photo = photoDetailVM.photos[indexPath.row]
        cell.photoImage.setImage(string: photo.url)
        cell.photoImage.enableZoom()
        cell.photoImage.resetZoom()
        titleLabel.text = photo.title
        return cell
    }
}

extension PhotoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
