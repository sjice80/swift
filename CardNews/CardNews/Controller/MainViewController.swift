//
//  MainViewController.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit
class MainViewController: UICollectionViewController {
    private let cardModel = CardModel()
    private var selectedCardCell : CardCell? = nil
    private struct StoryboardInfo {
        static var segueIdentifier: String = "Spread"
        static var cellIdentifier: String = "CardCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionViewLayout as? MainCollectionViewLayout {
            layout.cardModel = self.cardModel
        }
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return cardModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardInfo.cellIdentifier, for: indexPath)
   
        if let cardCell = cell as? CardCell {
            print("cardCell")
            let infos = cardModel.cards
            cardCell.Initialize(for: infos[indexPath.item])
            return cardCell
        }
        return cell
   }

   // MARK: UICollectionViewDelegate

   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    //print("shouldSelectItemAt")
       return true
   }

   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // perform segue
        selectedCardCell = collectionView.cellForItem(at: indexPath) as? CardCell
    //selectedIndex = indexPath
    //performSegue(withIdentifier: StoryboardInfo.segueIdentifier, sender: collectionView.cellForItem(at: indexPath))
    print("didSelectItemAt")
        performSegue(withIdentifier: StoryboardInfo.segueIdentifier, sender: nil)
   }
    /*
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == StoryboardInfo.segueIdentifier else {
            return
        }
        
        if let targetVC = segue.destination as? NewsViewController, let cardCell = sender as? CardCell {
            targetVC.bgColor = UIColor.yellow   // cardCell.backgroundColor
        }
    }
 */
}
extension MainViewController: SpreadViewController {
    func GetFromCardView() -> UIView {
        return selectedCardCell!.cardView
    }
    func GetToCardView() -> UIView {
        return selectedCardCell!.contentView
    }
    func AddCardView(v: UIView) {
        if let contentView = selectedCardCell?.contentView {
            contentView.addSubview(v)
            v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            v.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            v.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }
}
