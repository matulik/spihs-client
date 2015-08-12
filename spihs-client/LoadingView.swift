//
//  LoadingView.swift
//  spihs-client
//
//  Created by CS_praktykant on 10/08/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet var view: UIView!
    
    private var frameX : CGFloat = 0.0
    private var frameY : CGFloat = 0.0
    
    private var effectView : UIVisualEffectView = UIVisualEffectView()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func startLoading(mainView: UIView) {
        self.frameX = mainView.frame.width
        self.frameY = mainView.frame.height
        NSBundle.mainBundle().loadNibNamed("Loading", owner: self, options: nil)
        self.addSubview(self.view)
        self.center = CGPointMake(frameX/2-100, frameY/2-100)
        self.addBlurEffect(mainView)
        mainView.addSubview(self)
    }
    
    func stopLoading() {
        self.delBlurEffect()
        self.removeFromSuperview()
    }
    
    private func addBlurEffect(mainView: UIView) {
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        self.effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRectMake(0, 0, self.frameX, self.frameY)
        self.effectView.tag = 1
        mainView.addSubview(effectView)
    }
    
    private func delBlurEffect() {
        self.effectView.removeFromSuperview()
    }
}