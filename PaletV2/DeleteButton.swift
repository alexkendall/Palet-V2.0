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

class DeleteButton:MenuButton
{
    // override this method to draw add button
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        self.path.moveToPoint(CGPoint(x: rect.width * 0.15, y: rect.height * 0.5));
        self.path.addLineToPoint(CGPoint(x: rect.width * 0.85, y: rect.height * 0.5));

        self.icon_color.setStroke();
        self.path.lineWidth = self.line_width;
        self.path.stroke();
    }
}