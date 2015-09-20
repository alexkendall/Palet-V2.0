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

class FavoriteButton:MenuButton
{
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        
        path.moveToPoint(CGPointMake(0.50000 * CGRectGetWidth(frame), 0.05000 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.67634 * CGRectGetWidth(frame), 0.30729 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.97553 * CGRectGetWidth(frame), 0.39549 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.78532 * CGRectGetWidth(frame), 0.64271 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.79389 * CGRectGetWidth(frame), 0.95451 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.50000 * CGRectGetWidth(frame), 0.85000 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.20611 * CGRectGetWidth(frame), 0.95451 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.21468 * CGRectGetWidth(frame), 0.64271 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.02447 * CGRectGetWidth(frame), 0.39549 * CGRectGetHeight(frame)));
        path.addLineToPoint(CGPointMake(0.32366 * CGRectGetWidth(frame), 0.30729 * CGRectGetHeight(frame)));
        
        // note: cannot apply scale in draw in rect
        let scale = CGAffineTransformMakeScale(0.7, 0.7);
        let translate = CGAffineTransformTranslate(scale, frame.width * 0.2, frame.height * 0.2);
        path.applyTransform(translate);
        path.closePath();
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // override this method to draw add button
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        self.icon_color.setStroke();
        self.path.lineWidth = self.line_width;
        self.path.stroke();
        
    
    }
}
