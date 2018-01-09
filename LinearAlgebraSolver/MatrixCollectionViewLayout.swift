
import UIKit

class MatrixCollectionViewLayout: UICollectionViewLayout {
    
    fileprivate let CELL_HEIGHT = 65.0
    fileprivate let CELL_WIDTH  = 70.0
    fileprivate var offsetWidth = 0.0
    fileprivate var offsetHeight = 0.0
    fileprivate var cellHash = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    fileprivate var contentSize = CGSize(width: 0, height: 0)
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        
        computeWidthOffset()
        //computeHeightOffset()
        
        if collectionView!.numberOfSections > 0 {
            for section in 0...collectionView!.numberOfSections - 1 {
                
                if collectionView!.numberOfItems(inSection: section) > 0 {
                    for item in 0...collectionView!.numberOfItems(inSection: section) - 1{
                
                        let cellIndex = IndexPath(item: item, section: section)
                        let x = (Double(item) * CELL_WIDTH) + offsetWidth
                        let y = (Double(section) * CELL_HEIGHT) + offsetHeight
                
                        let cell = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                        cell.frame = CGRect(x: x, y: y, width: CELL_WIDTH, height: CELL_HEIGHT)
                
                        cellHash[cellIndex] = cell
                    }
                }
            }
            let contentWidth = (Double(collectionView!.numberOfItems(inSection: 0)) * CELL_WIDTH) + offsetWidth
            let contentHeight = (Double(collectionView!.numberOfSections) * CELL_HEIGHT) + offsetHeight
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
    
    func computeWidthOffset() {
        
        if collectionView!.numberOfSections > 0 {
            let containerWidth = Double(collectionView!.frame.width)
            let itemCount = Double(collectionView!.numberOfItems(inSection: 0))
            let rowLength = itemCount * CELL_WIDTH
        
            if rowLength < containerWidth {
                offsetWidth = (containerWidth - rowLength) / 2
            }
        }
    }
    
    func computeHeightOffset() {
        
        if collectionView!.numberOfSections > 0 && collectionView!.numberOfItems(inSection: 0) > 0 {
            let containerHeight = Double(collectionView!.frame.height)
            let itemCount = Double(collectionView!.numberOfSections)
            let colLength = itemCount * CELL_HEIGHT
        
            if colLength < containerHeight {
                offsetHeight = (containerHeight - colLength) / 2
            }
        }
    }
}
