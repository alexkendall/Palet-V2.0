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

class ViewButton:MenuButton
{
    // override this method to draw add button
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        self.path = UIBezierPath(ovalInRect: CGRect(x: rect.width * 0.25, y: rect.height * 0.25, width: rect.width * 0.3, height: rect.height * 0.3));
        
        path.moveToPoint(CGPoint(x: frame.width * 0.5, y: frame.height * 0.5));
        path.addLineToPoint(CGPoint(x: frame.width * 0.75, y: frame.height * 0.75));
        
        self.icon_color.setStroke();
        self.path.lineWidth = self.line_width;
        self.path.stroke();
    }
}