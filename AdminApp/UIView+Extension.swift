//
//  UIView+Extension.swift
//  dryv
//
//  Created by Ahmed M. Hassan on 7/15/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindToKeyboard(withTapGesture: Bool = false) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        if withTapGesture {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let cutFrame = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
        let targetFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        let deltaY = ((targetFrame?.cgRectValue.origin.y)! - (cutFrame?.cgRectValue.origin.y)!)
        
        UIView.animateKeyframes(withDuration: duration!, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            
            self.frame.size.height += deltaY
            
        }, completion: nil)
    }
    
    @objc private func handleScreenTap (sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    func fadeTo(alpha: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration) { 
            self.alpha = alpha
        }
    }
    
    func showLoading(_ shouldLoad: Bool) {
        
        var fadeView: UIView!
        let tag = 99
        
        if shouldLoad {
            fadeView = UIView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
            fadeView.tag = tag
            fadeView.backgroundColor = UIColor.black
            fadeView.alpha = 0
            
            let spinner = UIActivityIndicatorView()
            spinner.center = fadeView.center
            spinner.activityIndicatorViewStyle = .whiteLarge
            
            fadeView.addSubview(spinner)
            self.addSubview(fadeView)
            
            fadeView.fadeTo(alpha: 0.7, duration: 0.3)
        } else {
            for view in self.subviews {
                if view.tag == tag {
                    UIView.animate(withDuration: 0.3, animations: { 
                        view.alpha = 0
                    }, completion: { (completed) in
                        view.removeFromSuperview()
                    })
                }
            }
        }
        
    }
    
}
