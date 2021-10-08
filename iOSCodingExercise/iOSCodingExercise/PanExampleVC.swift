//
//  PanExampleVC.swift
//  iOSCodingExercise
//
//  Created by Sunny Chan on 10/8/21.
//

import UIKit

class PanExampleVC: UIViewController {
    let greenView: UIView = UIView()
    let redView: UIView = UIView()
    var panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    override func loadView() {
        super.loadView()
        loadSubviews()
        loadPanRecognizer()
        setUpAndActivateAutoLayout()
    }
}

// MARK: - View Setup

extension PanExampleVC {
    func loadSubviews() {
        loadGreenView()
        loadRedView()
    }
    
    func loadGreenView() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green
        view.addSubview(greenView)
    }
    
    func loadRedView() {
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red
        view.addSubview(redView)
    }
    
    func loadPanRecognizer() {
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        greenView.addGestureRecognizer(panRecognizer)
    }
    
    @objc func onPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        
        guard let pannedView = recognizer.view else {
            return
        }
        
        let updatedCenterX: CGFloat = pannedView.center.x + translation.x
        pannedView.center = CGPoint(x: updatedCenterX, y: pannedView.center.y)
        
        let endOfGreenX: CGFloat = pannedView.frame.origin.x + pannedView.frame.width
        let beginningOfRedX: CGFloat = redView.frame.origin.x
        let isWithInThresHold: Bool = beginningOfRedX - endOfGreenX <= 10
        let isMovingForward: Bool = translation.x > 0
        
        if isWithInThresHold && isMovingForward {
            redView.center = CGPoint(x: redView.center.x + translation.x, y: redView.center.y)
        }
        
        // NOTE: Reset the translation to avoid compounding effect whenever onPan is called.
        recognizer.setTranslation(.zero, in: view)
    }
}

// MARK: - Auto Layout Setup

extension PanExampleVC {
    var views: [String: UIView] {
        let dict: [String: UIView] = ["greenView": greenView, "redView": redView]
        return dict
    }
    
    var allConstraints: [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        constraints += greenViewHConstraints
        constraints += greenViewVConstraints
        constraints += redViewHConstraints
        constraints += redViewVConstraints
        return constraints
    }
    
    var greenViewHConstraints: [NSLayoutConstraint] {
        let VFLStr: String = "H:|-16-[greenView(50)]"
        return NSLayoutConstraint.constraints(withVisualFormat: VFLStr, options: [], metrics: nil, views: views)
    }
    
    var redViewHConstraints: [NSLayoutConstraint] {
        let VFLStr: String = "H:[greenView]-40-[redView(50)]"
        return NSLayoutConstraint.constraints(withVisualFormat: VFLStr, options: [], metrics: nil, views: views)
    }
    
    var greenViewVConstraints: [NSLayoutConstraint] {
        let VFLStr: String = "V:|-16-[greenView(80)]"
        return NSLayoutConstraint.constraints(withVisualFormat: VFLStr, options: [], metrics: nil, views: views)
    }
    
    var redViewVConstraints: [NSLayoutConstraint] {
        let VFLStr: String = "V:|-16-[redView(80)]"
        return NSLayoutConstraint.constraints(withVisualFormat: VFLStr, options: [], metrics: nil, views: views)
    }
    
    func setUpAndActivateAutoLayout() {
        NSLayoutConstraint.activate(allConstraints)
    }
}
