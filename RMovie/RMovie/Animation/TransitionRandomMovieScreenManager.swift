//
//  TransitionRandomMovieScreenManager.swift
//  RMovie
//
//  Created by mac on 1/14/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class TransitionRandomMovieScreenManager: NSObject {
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // TODO: Perform the animation
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        // start the toView to the right of the screen
        toView.transform = offScreenRight
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext: transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .allowAnimatedContent, animations: {
            fromView.transform = offScreenLeft
            //toView.transform = CGAffineTransformIdentity.inverted()
        }) { (finished) in
            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(true)
        }
        
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> TimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // remmeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//    
//    // return the animator used when dismissing from a viewcontroller
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
}
