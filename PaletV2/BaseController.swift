//
//  BaseController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/18/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

// base class view controller for controllers other than navigation controller 
// includes the following capbilities:
// 1. animation out of window to write
// 2. animate out of window to left
// 3. animate into window
// the controller also does not span the area where the main navigation button is
class AuxillaryController:UIViewController
{
    var left_frame:CGRect!;
    var right_frame:CGRect!;
    var in_frame:CGRect!;
    var super_view:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        super_view = self.view;
        let header:CGFloat = 55.0;
        super_view.frame = CGRect(x: 0.0, y: 55.0, width: super_view.bounds.width, height: super_view.bounds.height - header);
        in_frame = super_view.frame;
        left_frame = CGRect(x: -super_view.bounds.width, y: header, width: super_view.bounds.width, height: super_view.bounds.height);
        right_frame = CGRect(x: super_view.bounds.width, y: header, width: super_view.bounds.width, height: super_view.bounds.height);
    }
    
    func push_right(duration:NSTimeInterval)
    {
        let r_frame = CGRect(x: super_view.bounds.width, y: super_view.frame.origin.y, width: super_view.bounds.width, height: self.super_view.bounds.height);
        UIView.animateWithDuration(duration, animations: {
            
            self.super_view.frame = r_frame;
            self.super_view.alpha = 0.0;    // dissolve
        });
    }
    
    func push_left(duration:NSTimeInterval)
    {
        let l_frame = CGRect(x: -super_view.bounds.width, y: super_view.frame.origin.y, width: super_view.bounds.width, height: self.super_view.bounds.height);
        UIView.animateWithDuration(duration, animations: {
            
            self.super_view.frame = l_frame;
            self.super_view.alpha = 0.0;    // dissolve
        });
    }
    
    func show(duration:NSTimeInterval)
    {
        UIView.animateWithDuration(duration, animations: {
            self.super_view.frame = self.in_frame;
            self.super_view.alpha = 1.0;    // dissolve
        });
    }
    
    func place_left()
    {
        super_view.frame = CGRect(x: -super_view.bounds.width, y: super_view.frame.origin.y, width: super_view.bounds.width, height: self.super_view.bounds.height);
    }
    
    func place_right()
    {
        super_view.frame = CGRect(x: super_view.bounds.width, y: super_view.frame.origin.y, width: super_view.bounds.width, height: self.super_view.bounds.height);
    }
    
    
}