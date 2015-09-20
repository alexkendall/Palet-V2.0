//
//  NavButton.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class NavButton:UIButton
{
    var toggled_on:Bool = false;
    var draw_color:UIColor = UIColor.blackColor();
    override init(frame: CGRect)
    {
        
        super.init(frame:frame);
    }
    override func drawRect(rect: CGRect) {
        
        // create path
        let path = UIBezierPath();
        path.lineWidth = 4.0
        
        // configure path
        path.moveToPoint(CGPoint(x: frame.width * 0.1, y: frame.height * 0.25));
        path.addLineToPoint(CGPoint(x: frame.width * 0.9, y: frame.height * 0.25));
        
        path.moveToPoint(CGPoint(x: frame.width * 0.1, y: frame.height * 0.5));
        path.addLineToPoint(CGPoint(x: frame.width * 0.9, y: frame.height * 0.5));
        
        path.moveToPoint(CGPoint(x: frame.width * 0.1, y: frame.height * 0.75));
        path.addLineToPoint(CGPoint(x: frame.width * 0.9, y: frame.height * 0.75));
        
        // render
        draw_color.setStroke();
        path.stroke();
        
        self.addTarget(self, action: "select", forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    func select()
    {
        if(toggled_on)
        {
            draw_color = UIColor.blackColor();
            toggled_on = false;
            setNeedsLayout();
            setNeedsDisplay();
        }
        else
        {
            draw_color = UIColor.lightGrayColor();
            toggled_on = true;
            setNeedsLayout();
            setNeedsDisplay();
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
