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

class CheckButton:ControlButton
{
    
    override init(x: CGFloat, y: CGFloat, in_highlight_color: UIColor, in_unhigh_color: UIColor, dim: CGFloat) {
        super.init(x: x, y: y,in_highlight_color: in_highlight_color, in_unhigh_color: in_unhigh_color, dim: dim);
        
        active_flag = true;
        setNeedsDisplay();
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
       
        // create path
        let path = UIBezierPath();
        path.lineWidth = self.line_width;
        let start_x:CGFloat = frame.width * 0.15;
        let start_y:CGFloat = frame.height * 0.6;
        
        // configure path
        path.moveToPoint(CGPoint(x: start_x, y: start_y));
        path.addLineToPoint(CGPoint(x: frame.width * 0.5, y: frame.height * 0.85));
        path.addLineToPoint(CGPoint(x: frame.width * 0.75, y: frame.height * 0.25));
        
        // render
        if(!active_flag)
        {
            self.icon_color = UIColor.whiteColor();
        }
        else
        {
            self.icon_color = UIColor.clearColor();
        }
        icon_color.setStroke();
        path.stroke();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
