//
//  MatrixCollectionViewLayout.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 12/21/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import UIKit

class MatrixCollectionViewLayout: UICollectionViewLayout {
    
    fileprivate let CELL_HEIGHT = 65.0
    fileprivate let CELL_WIDTH  = 70.0
    fileprivate var cellHash = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    fileprivate var contentSize = CGSize(width: 0, height: 0)
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        
        if collectionView!.numberOfSections > 0 {
            for section in 0...collectionView!.numberOfSections - 1{
                
                if collectionView!.numberOfItems(inSection: section) > 0 {
                    for item in 0...collectionView!.numberOfItems(inSection: section) - 1{
                
                        let cellIndex = IndexPath(item: item, section: section)
                        let x = Double(item) * CELL_WIDTH
                        let y = Double(section) * CELL_HEIGHT
                
                        let cell = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                        cell.frame = CGRect(x: x, y: y, width: CELL_WIDTH, height: CELL_HEIGHT)
                
                        cellHash[cellIndex] = cell
                    }
                }
            }
            let contentWidth = Double(collectionView!.numberOfItems(inSection: 0)) * CELL_WIDTH
            let contentHeight = Double(collectionView!.numberOfSections) * CELL_HEIGHT
            self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
        
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for (_, cellAttributes) in cellHash {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        return attributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellHash[indexPath]!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
}
