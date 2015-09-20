//
//  heart_rate.swift
//  HealthApp
//
//  Created by Alex Harrison on 8/6/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

// base class for spring board buttons
class ControlButton:MenuButton
{
    init(x:CGFloat, y:CGFloat, in_highlight_color:UIColor, in_unhigh_color:UIColor, dim:CGFloat)
    {
        super.init(frame: CGRect(x: x, y: y, width: dim, height: dim));

        removeTarget(self, action: "unhighlight_color", forControlEvents: UIControlEvents.TouchUpInside);
        removeTarget(self, action: "unhighlight_color", forControlEvents: UIControlEvents.TouchUpOutside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        self.layer.cornerRadius = rect.width * 0.5;
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        self.layer.shadowOpacity = Float(0.5);
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.borderColor = self.border_color.CGColor;
        self.layer.borderWidth = self.border_width;
        self.clipsToBounds = true;

    }
    
    // highlights the button
    // this will only occur if the view corresponding to that button is loaded
    override func highlight_color()
    {
        if(active_flag)
        {
            self.backgroundColor = high_color;
            self.setNeedsDisplay();
            set_not_active();
        }
        else
        {
            self.backgroundColor = un_high_color;
            self.setNeedsDisplay();
            set_active();
        }
    }
    
}