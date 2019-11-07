//
//  RainbowLayout.swift
//  CollectionViewTest
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

class RainbowLayout: UICollectionViewFlowLayout {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let view = collectionView {
            let cellWidth = view.bounds.width - 20
            itemSize = CGSize(width: cellWidth, height: 100)
        }
    }
}
