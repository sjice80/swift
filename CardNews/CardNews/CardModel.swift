//
//  CardModel.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit
struct CardInfo {
    var backgroundColor: UIColor
    var title: String
    var height: CGFloat
    init(_ titleString: String, _ bgColor: UIColor, _ cellHeight: CGFloat) {
        title = titleString
        backgroundColor = bgColor
        height = cellHeight
    }
}
class CardModel {
    var cards: Array<CardInfo>
    var count: Int {
        get {
            return cards.count
        }
    }
    init() {
        cards = Array<CardInfo>()
        cards.append(CardInfo("First", UIColor.red, 100))
        cards.append(CardInfo("Second", UIColor.orange, 180))
        cards.append(CardInfo("Third", UIColor.yellow, 130))
        cards.append(CardInfo("Fourth", UIColor.green, 280))
        cards.append(CardInfo("Fifth", UIColor.blue, 150))
    }
    func addInfo(title: String, color: UIColor, height: CGFloat) {
        cards.append(CardInfo(title, color, height))
    }
    
}
