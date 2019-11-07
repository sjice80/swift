//
//  ColorViewController.swift
//  CollectionViewTest
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = bgColor
    }
}

extension ColorViewController : SpreadViewController {
    func GetImageView() -> UIImageView? {
        return imageView
    }
    
    func GetCornerRadius() -> CGFloat {
        return CGFloat(0.0)
    }
}

