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
    
    let indentBetweenItems: CGFloat = 8
    let cellCollectionPhotosID = "cellCollectionPhotosID"
    
    
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
    func setupMainView(){
        navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    
    func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: cellCollectionPhotosID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func setupConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       
        [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
}
