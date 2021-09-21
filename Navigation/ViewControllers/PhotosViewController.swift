//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService

class PhotosViewController: UIViewController {

    
    private lazy var collectionView: UICollectionView = {
        let layoutCollectionView = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView)
        return collectionView
    }()
    
    private let indentBetweenItems: CGFloat = 8
    private let cellCollectionPhotosID = "cellCollectionPhotosID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupConstraints()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionView()
    }
    
    
    // MARK: - Setups
    private func setupMainView(){
        navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: cellCollectionPhotosID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func setupConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       
        [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        .forEach{ $0.isActive = true}
    }
}


// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosImage.photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCollectionPhotosID, for: indexPath) as! PhotosCollectionViewCell
        cell.photoImage.image  = PhotosImage.photos[indexPath.row]
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sideSize = CGFloat((collectionView.frame.width - indentBetweenItems * 4) / 3)
        
        return CGSize(width: sideSize, height: sideSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return indentBetweenItems
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return indentBetweenItems
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: indentBetweenItems,
            left: indentBetweenItems,
            bottom: indentBetweenItems,
            right: indentBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = PhotoViewController()
        image.imageView.image = PhotosImage.photos[indexPath.row]
        present(image, animated: true)
    }
}

