//
//  NewsViewController.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cardView.backgroundColor = bgColor
    }
}
extension NewsViewController: SpreadViewController {
    func GetFromCardView() -> UIView {
        return cardView!
    }
    func GetToCardView() -> UIView {
        return self.view
    }
    func AddCardView(v: UIView) {
        self.view.addSubview(v)
        v.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        v.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        v.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        v.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cardView = v
    }
}
