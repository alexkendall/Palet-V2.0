//
//  SearchIcon.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/17/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class PickerButton:MenuButton
{
    var circle1 = UIBezierPath();
    var circle2 = UIBezierPath();
    var circle3 = UIBezierPath();
    var rgb = [UIColor.blackColor(), UIColor.blackColor(), UIColor.blackColor()];
    
    
    // override this method to draw add button
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        // get square dimensions
        let sub_frame_dim:CGFloat = frame.width * 0.4;
        
        // configure frame 1
        let frame1:CGRect = CGRect(x: (frame.width - sub_frame_dim) * 0.5, y: frame.height * 0.15, width: sub_frame_dim, height: sub_frame_dim);
        
        // configure frame 2
        let frame2:CGRect = CGRect(x: (frame.width - sub_frame_dim) * 0.25, y: frame.height * 0.4, width: sub_frame_dim, height: sub_frame_dim);
        
        // configure frame 3
        let frame3:CGRect = CGRect(x: (frame.width - sub_frame_dim) * 0.75, y: frame.height * 0.4, width: sub_frame_dim, height: sub_frame_dim);
        
        var circles = [circle1, circle2, circle3];
        var frames = [frame1, frame2, frame3];
        for(var i = 0; i < 3; ++i)
        {
            circles[i] = UIBezierPath(ovalInRect: frames[i]);
            rgb[i].setStroke();
            circles[i].lineWidth = self.line_width
            circles[i].stroke();
        }
    }
    
    // custom highlight to show rgb component circles
    override func highlight_color() {
        super.highlight_color();
        rgb = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()];
        for(var i = 0; i < 3; ++i)
        {
            setNeedsDisplay();
        }
    }
    override func unhighlight_color() {
        super.unhighlight_color();
        rgb = [UIColor.blackColor(), UIColor.blackColor(), UIColor.blackColor()];
    }
}