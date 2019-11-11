//
//  SpreadTransitionDelegate.swift
//  CardNews
//
//  Created by SueJung Kim on 07/11/2019.
//  Copyright © 2019 SueJung Kim. All rights reserved.
//

import UIKit

protocol SpreadViewController {
    func GetFromCardView() -> UIView
    func GetToCardView() -> UIView
    func AddCardView(v: UIView)
    //func GetImageView() -> UIImageView?
    
}

class SpreadTransitionDelegate : NSObject {
    private var transitionDuration = 0.5
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
        
        if let fromView = (fromVC as? SpreadViewController)?.GetFromCardView(),
            let toView = (toVC as? SpreadViewController)?.GetToCardView() {
            let snapshotView = UIView()
            snapshotView.frame = fromView.superview!.convert(fromView.frame, to: containerView)
            
            fromView.removeFromSuperview()
            snapshotView.addSubview(fromView)
            
            fromView.leadingAnchor.constraint(equalTo: snapshotView.leadingAnchor).isActive = true
            fromView.trailingAnchor.constraint(equalTo: snapshotView.trailingAnchor).isActive = true
            fromView.topAnchor.constraint(equalTo: snapshotView.topAnchor).isActive = true
            fromView.bottomAnchor.constraint(equalTo: snapshotView.bottomAnchor).isActive = true
            
            containerView.addSubview(fromVC.view)
            containerView.addSubview(toVC.view)
            containerView.addSubview(snapshotView)
            
            UIView.animate(withDuration: transitionDuration, animations: {
                let toFrame = toView.convert(toView.frame, to: containerView)
                snapshotView.frame = toFrame
                snapshotView.layoutIfNeeded()
            }) { (completed) in
                fromView.removeFromSuperview()
                (toVC as? SpreadViewController)?.AddCardView(v: fromView)
                snapshotView.removeFromSuperview()
                toVC.view.backgroundColor = UIColor.white
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
extension SpreadTransitionDelegate : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is SpreadViewController, toVC is SpreadViewController {
            return self
        }
        return nil
    }
}

