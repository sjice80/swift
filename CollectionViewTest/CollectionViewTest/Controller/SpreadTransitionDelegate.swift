//
//  SpreadTransitionDelegate.swift
//  CollectionViewTest
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

protocol SpreadViewController {
    func GetImageView() -> UIImageView?
    func GetCornerRadius() -> CGFloat
}

class SpreadTransitionDelegate : NSObject {
    private var transitionDuration = 0.5
    private var fromCornerRadius: CGFloat = 0.0
    private var toCornerRadius: CGFloat = 0.0
}

// MARK: UIViewControllerAnimatedTransitioning

extension SpreadTransitionDelegate : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
     
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        if let fromImageView = (fromVC as? SpreadViewController)?.GetImageView(),
            let toImageView = (toVC as? SpreadViewController)?.GetImageView() {
            let snapshotView = UIImageView(image: fromImageView.image)
            snapshotView.layer.cornerRadius = fromCornerRadius
            snapshotView.layer.masksToBounds = true
            snapshotView.backgroundColor = fromImageView.backgroundColor
            snapshotView.frame = containerView.convert(fromImageView.frame, from: fromImageView.superview)
            
            fromImageView.isHidden = true
            toImageView.isHidden = true
            
            containerView.addSubview(fromVC.view)
            containerView.addSubview(toVC.view)
            containerView.addSubview(snapshotView)
            
            UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                snapshotView.frame = containerView.convert(toImageView.frame, from: toImageView.superview)
                snapshotView.layer.cornerRadius = self.toCornerRadius
            }) { (completed) in
                fromImageView.isHidden = false
                toImageView.isHidden = false
                snapshotView.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

extension SpreadTransitionDelegate : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let from = fromVC as? SpreadViewController, let to = toVC as? SpreadViewController {
            fromCornerRadius = from.GetCornerRadius()
            toCornerRadius = to.GetCornerRadius()
            return self
        }
        return nil
    }
}
