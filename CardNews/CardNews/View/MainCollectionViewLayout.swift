//
//  MainCollectionViewLayout.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit
class MainCollectionViewLayout: UICollectionViewLayout {
    public var cardModel: CardModel!
    private var attributes = [UICollectionViewLayoutAttributes]()
    override var collectionViewContentSize: CGSize {
        return collectionView?.bounds.size ?? CGSize(width: 0, height: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepare() {
        guard let numberOfCell = collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        var cellOriginYSet: [CGFloat] = [0, 0]
        for cellIndex in 0..<numberOfCell {
            let cellHeight = cardModel.cards[cellIndex].height
            let cellWidth = collectionViewContentSize.width/2
            var cellFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            cellFrame.origin.x = (collectionViewContentSize.width/2)*CGFloat(cellIndex%2)
            cellFrame.origin.y = cellOriginYSet[cellIndex%2]
            cellFrame.size.width = cellWidth
            cellFrame.size.height = cellHeight
            cellOriginYSet[cellIndex%2] = cellHeight
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: cellIndex, section: 0))
            attribute.frame = cellFrame.insetBy(dx: 10, dy: 10)
            attributes.append(attribute)
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        NSLog("attribute for visible area")
        var visibleAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in attributes {
            if(attribute.frame.intersects(rect)) {
                visibleAttributes.append(attribute)
            }
        }
        return visibleAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        NSLog("attribute for index path")
        return attributes[indexPath.item]
    }
}
