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
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.addBehaviour()
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehaviour(){
        NSBundle.mainBundle().loadNibNamed("Loading", owner: self, options: nil)
        self.addSubview(self.view)
    }
}
