//
//  RainbowCollectionController.swift
//  CollectionViewTest
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

class RainbowCollectionController: UICollectionViewController {
    
    private let cellInfos: Array<ColorCellInfo> = ColorCellInfo.GenerateRainbow()
    private var selectedIndex: IndexPath!
    
    private struct Storyboard {
        static let cellIdentifier = "ColorCell"
        static let headerIdentifier = "RainbowHeader"
        static let segueIdentifier = "Spread"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellWidth = view.bounds.width - 20
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: cellWidth, height: 100)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInfos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.headerIdentifier, for: indexPath)
            
            return header
            
        default:
            assert(false, "unexpected kind value")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIdentifier, for: indexPath)
    
        guard let colorCell = cell as? ColorCell else {
            return cell
        }
        
        // configure color cell
        colorCell.imageView.backgroundColor = cellInfos[indexPath.item].color
        colorCell.layer.cornerRadius = 15.0
        colorCell.layer.masksToBounds = true
    
        return colorCell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // perform segue
        selectedIndex = indexPath
        performSegue(withIdentifier: Storyboard.segueIdentifier, sender: collectionView.cellForItem(at: indexPath))
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Storyboard.segueIdentifier else {
            return
        }
        
        if let targetVC = segue.destination as? ColorViewController, let colorCell = sender as? ColorCell {
            targetVC.bgColor = colorCell.imageView.backgroundColor
        }
    }
}

extension RainbowCollectionController : SpreadViewController {
    func GetImageView() -> UIImageView? {
        if selectedIndex != nil {
            let cell = collectionView.cellForItem(at: selectedIndex) as! ColorCell
            return cell.imageView
        }
        return nil
    }
    
    func GetCornerRadius() -> CGFloat {
        return CGFloat(15.0)
    }
}

