//
//  PhotoDetailViewController.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoDetailCollectionView: UICollectionView!

    var vm = PhotoDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailCollectionView.delegate = self
        photoDetailCollectionView.dataSource = self
    }

}

extension PhotoDetailViewController: UICollectionViewDelegate {

}

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoDetailCollectionViewCell", for: indexPath) as? PhotoDetailCollectionViewCell else { return .init() }
        return cell
    }
}
