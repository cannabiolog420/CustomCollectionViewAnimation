//
//  ResizableLayour.swift
//  BasicCollectionAnimationProject
//
//  Created by cannabiolog420 on 22.03.2021.
//

import Foundation
import UIKit


struct ContextCellConstants {
    static let selectedHeight:CGFloat = 200
    static let defaultHeight:CGFloat = 100
    
}

class ResizableLayout:UICollectionViewLayout{
    
    let dragOffset:CGFloat = ContextCellConstants.selectedHeight - ContextCellConstants.defaultHeight
    
    
    var cacheAttributes = [UICollectionViewLayoutAttributes]()
    
    var selectedItemIndex:Int{
        max(0,Int(collectionView!.contentOffset.y / dragOffset))
    }
    
    var percentageOffset:CGFloat{
        collectionView!.contentOffset.y / dragOffset - CGFloat(selectedItemIndex)
    }
    
    var width:CGFloat{
        collectionView!.bounds.width
    }
    
    var height:CGFloat{
        collectionView!.bounds.height
    }
    
    var numberOfItems:Int{
        collectionView!.numberOfItems(inSection: 0)
    }
    
    
}


extension ResizableLayout{
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize{
        CGSize(width: width,
               height: CGFloat(numberOfItems) * dragOffset + height - dragOffset)
    }
    
    override func prepare() {
        
        cacheAttributes.removeAll()
        
        var frame:CGRect = .zero
        var y:CGFloat = 0
        
        for index in 0..<numberOfItems{
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            var height = ContextCellConstants.defaultHeight
            
            // selected
            if indexPath.item == selectedItemIndex{
                
                y = collectionView!.contentOffset.y - ContextCellConstants.defaultHeight * percentageOffset
                height = ContextCellConstants.selectedHeight
            }else if indexPath.item == (selectedItemIndex + 1){
                height = ContextCellConstants.defaultHeight + max(0,dragOffset * percentageOffset)
                
                let maxY = y + ContextCellConstants.defaultHeight
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            
            attributes.zIndex = index
            cacheAttributes.append(attributes)
            y = frame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var resultAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cacheAttributes{
            if attributes.frame.intersects(rect){
                resultAttributes.append(attributes)
            }
        }
        return resultAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let index = round(proposedContentOffset.y / dragOffset)
        let y = index  * dragOffset
        
        return CGPoint(x: 0, y: y)
    }
}
