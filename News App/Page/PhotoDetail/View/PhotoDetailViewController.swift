//
//  PhotoDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoDetailCollectionView: UICollectionView!

    var photoDetailVM = PhotoDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailCollectionView.delegate = self
        photoDetailCollectionView.dataSource = self
        photoDetailCollectionView.register(UINib(nibName: "PhotoDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoDetailCollectionViewCell")
    }
}

extension PhotoDetailViewController: UICollectionViewDelegate { }

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDetailVM.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoDetailCollectionViewCell", for: indexPath) as? PhotoDetailCollectionViewCell else { return .init() }
        cell.photoImage.setImage(string: photoDetailVM.photos[indexPath.row].url)
        return cell
    }
}
