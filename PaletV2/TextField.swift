//
//  TextField.swift
//  PaletV2
//
//  Created by Alex Harrison on 10/8/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import UIKit
import Foundation

class TextField:UITextField
{
    var text_offset:CGFloat = 10.0; // default text offset for iphone6
    
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(x: text_offset, y: 0.0, width: bounds.width - text_offset, height: bounds.height);
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(x: text_offset, y: 0.0, width: bounds.width - text_offset, height: bounds.height);
    }
    
    func set_text_offset(offset_x:CGFloat)
    {
        self.text_offset = offset_x;
    }
}