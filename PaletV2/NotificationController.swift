//
//  NotificationController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/19/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class NotificationController:UIViewController
{
    var out_frame:CGRect!;
    var in_frame:CGRect!;
    var label:UILabel!;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        in_frame = CGRect(x: 0.0, y: nav_controller.view.bounds.height - 50.0, width: nav_controller.view.bounds.width, height: 50.0);
        
        out_frame = CGRect(x: 0.0, y: nav_controller.view.bounds.height, width: nav_controller.view.bounds.width, height: 50.0);
        
        self.view.frame = out_frame;
        self.view.backgroundColor = UIColor.whiteColor();
        
        
        label = UILabel(frame: CGRect(x: 15.0, y: 0.0, width: self.view.bounds.width - 15.0, height: self.view.bounds.height));
        self.view.addSubview(label);
        
        label.textColor = UIColor.blackColor();
    }
    
    func show(text:String)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = self.in_frame;
        });
        
        UIView.animateWithDuration(0.5, delay: 2.5, options:UIViewAnimationOptions.TransitionNone, animations: {
            self.view.frame = self.out_frame;
            }, completion: nil);
        
        label.text = text;
    }
    
    func hide()
    {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = self.out_frame;
        });
    }
    
    

}