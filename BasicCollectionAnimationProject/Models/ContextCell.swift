//
//  ContextCell.swift
//  BasicCollectionAnimationProject
//
//  Created by cannabiolog420 on 22.03.2021.
//

import UIKit

class ContextCell: UICollectionViewCell {
	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	static let reuseIdentifier = String(describing: ContextCell.self)
	
    
	var album: Album? {
		didSet {
			if let album = album {
				backgroundImageView.image = album.background
				timeLabel.text = album.time
				titleLabel.text = album.title
                backgroundImageView.contentMode = .scaleToFill
			}
		}
	}
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let dragOffset = ContextCellConstants.selectedHeight - ContextCellConstants.defaultHeight
        
        let delta = 1 - (ContextCellConstants.selectedHeight - frame.height) / dragOffset
        
        let minAlpha:CGFloat = 0.3
        let maxAlpha:CGFloat = 0.75
        
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        timeLabel.alpha = delta
        
        shadowView.alpha = maxAlpha - delta * (maxAlpha - minAlpha)
    }
}
