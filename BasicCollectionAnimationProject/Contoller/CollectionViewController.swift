//
//  CollectionViewController.swift
//  BasicCollectionAnimationProject
//
//  Created by cannabiolog420 on 22.03.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    let albums = AlbumsStorage.albums
    
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let backgroundView = UIImageView(image: Assets.image.background)
		collectionView?.backgroundView = backgroundView
        
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast

	}
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContextCell.reuseIdentifier, for: indexPath) as! ContextCell
        let album = albums[indexPath.item]
        cell.album = album
        
        return cell
    }

}
