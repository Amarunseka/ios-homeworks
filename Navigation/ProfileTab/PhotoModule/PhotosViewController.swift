//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController {

    private let imagePublisherFacade = ImagePublisherFacade()
    private let imageProcessor = ImageProcessor()
    private var photoForPublisher: [UIImage] = []

    
    private lazy var collectionView: UICollectionView = {
        let layoutCollectionView = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layoutCollectionView)
        return collectionView
    }()
    
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let indentBetweenItems: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupConstraints()
        setupActivityIndicator()
        receivePhoto()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.isHidden = true
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
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

    
    private func receivePhoto(){
        
        var currentPhotoForPublisher: [UIImage] = []
        let start = Date()
        let userCalendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [.second, .nanosecond]


        imageProcessor.processImagesOnThread(
            sourceImages: PhotosImage.photos,
            filter: .noir,
            qos: .default) { [self]
                images in
                for image in images {
                    if let image = image {
                        currentPhotoForPublisher.append(UIImage(cgImage: image))
                    }
                }
                
                DispatchQueue.main.async {
                    imagePublisherFacade.subscribe(self)
                    
                    imagePublisherFacade.addImagesWithTimer(
                        time: 0.8,
                        repeat: currentPhotoForPublisher.count * 2,
                        userImages: currentPhotoForPublisher)
                    
                    self.collectionView.reloadData()
                    activityIndicator.stopAnimating()
                    
                    let dateStop = Date()
                    let timeDifference = userCalendar.dateComponents(
                        requestedComponent,
                        from: dateStop,
                        to: start)
                    
                    print("\(timeDifference.second! * -1).\(timeDifference.nanosecond! * -1)")
                }
            }
    }
    
    // фильтр - noir, qos - default = 4.997
    // фильтр - noir, qos - userInteractive = 5.339
    // фильтр - colorInvert, qos - userInteractive = 4.984
    // фильтр - colorInvert, qos - background = 26.346
    // фильтр - gaussianBlur(radius: 0.7), qos - background = 18.654
    
    
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func setupActivityIndicator(){
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    private func setupConstraints(){
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
        return photoForPublisher.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
            for: indexPath) as! PhotosCollectionViewCell
        
        cell.photoImage.image = photoForPublisher[indexPath.row]
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
        image.imageView.image = photoForPublisher[indexPath.row]
        present(image, animated: true)
    }
}


extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photoForPublisher = images
        guard (images.count - 1) == collectionView.numberOfItems(inSection: 0) else {return}
        let indexPath = IndexPath(item: images.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
}
