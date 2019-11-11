//
//  CardCell.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func Initialize(for info: CardInfo) {
        headlineLabel.text = info.title
        headlineImageView.backgroundColor = info.backgroundColor
        //heightConstraint.constant = info.height - layoutMargins.bottom - layoutMargins.top
    }
}
