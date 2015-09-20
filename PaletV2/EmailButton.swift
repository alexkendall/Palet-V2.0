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

class EmailButton:MenuButton
{
    // override this method to draw add button
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let email_rect:CGRect = CGRect(x: frame.width * 0.2, y: frame.height * 0.3, width: frame.width * 0.6, height: frame.height * 0.4);
        path = UIBezierPath(roundedRect: email_rect, cornerRadius: 2.0);
        
        let top_left = CGPoint(x: email_rect.minX, y: email_rect.minY);
        let top_right = CGPoint(x: email_rect.maxX, y: email_rect.minY);
        path.moveToPoint(top_left);
        path.addLineToPoint(CGPoint(x: frame.width * 0.5, y: frame.height * 0.5));
        path.addLineToPoint(top_right);
        
        self.path.lineWidth = self.line_width;
        self.path.stroke();
    }
}