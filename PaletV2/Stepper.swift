//
//  Stepper.swift
//  PaletV2
//
//  Created by Alex Harrison on 10/9/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class Stepper:UIView
{
    var incr_button:AddButton!;
    var decr_button:SubButton!;
    var value:UInt8 = 0;
    
    override init(frame:CGRect)
    {
        super.init(frame: frame);
        incr_button = AddButton(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.5));
        incr_button.set_square();
        incr_button.layer.borderWidth = 1.0;
        incr_button.set_unhighlight_color(UIColor.whiteColor());
        incr_button.set_image_color(UIColor.blackColor());
        incr_button.set_highlight_color(UIColor.lightGrayColor());
        incr_button.set_border_width(1.0);
        incr_button.set_path_width(1.0);
        incr_button.set_border_color(UIColor.blackColor());
        incr_button.setNeedsDisplay();
        incr_button.layer.cornerRadius = incr_button.bounds.height * 0.1;
        incr_button.addTarget(self, action: "increment", forControlEvents: UIControlEvents.TouchDown);

        decr_button = SubButton(frame:CGRect(x: 0.0, y:frame.height * 0.5, width: frame.width, height: frame.height * 0.5));
        decr_button.set_square();
        decr_button.set_border_color(UIColor.blackColor());
        decr_button.set_unhighlight_color(UIColor.whiteColor());
        decr_button.set_highlight_color(UIColor.lightGrayColor());
        decr_button.set_image_color(UIColor.blackColor());
        decr_button.set_border_width(1.0);
        decr_button.set_path_width(1.0);
        decr_button.layer.cornerRadius = decr_button.bounds.height * 0.1;
        decr_button.addTarget(self, action: "decrement", forControlEvents: UIControlEvents.TouchDown);
        
        self.addSubview(incr_button);
        self.addSubview(decr_button);
        
        backgroundColor = UIColor.clearColor();
    }
    
    func set_value(in_value:UInt8)
    {
        self.value = in_value;
    }
    
    func increment()
    {
        ++value;
        print(value);
    }
    
    // enforces int to be positive
    func decrement()
    {
        if(value > 0)
        {
        --value;
        }
        print(value);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let inc_path:UIBezierPath = UIBezierPath();
        inc_path.moveToPoint(CGPoint(x: rect.width * 0.2, y: rect.height * 0.25));
        inc_path.addLineToPoint(CGPoint(x: rect.width * 0.8, y: rect.height * 0.25));
        inc_path.lineWidth = 1.0;
        UIColor.blackColor().setStroke();
        inc_path.stroke();
    }
}


