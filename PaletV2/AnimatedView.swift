//
//  AnimatedView.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/17/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

// protocol for providing animated views and buttons
class AnimatedView:UIView, AnimatedViewProtocol
{
    // each animated view must have an in frame or an out frame
    var in_frame:CGRect!;
    var out_frame:CGRect!;
    
    init()
    {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0));
    }
    
    
    // must provide constructor that sets in and out frames
    init(in_frame:CGRect, out_frame:CGRect)
    {
        super.init(frame: in_frame);
        self.in_frame = in_frame;
        self.out_frame = out_frame;

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // animation that shows view
    func show(duration:NSTimeInterval)
    {
        UIView.animateWithDuration(duration, animations: {
            self.frame = self.in_frame;
        })
    }
    
    // animation which hides view
    func hide(duration:NSTimeInterval)
    {
        UIView.animateWithDuration(duration, animations: {
            self.frame = self.out_frame;
        })
    }
}