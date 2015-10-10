//
//  NotificationController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/19/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class OperationController:NotificationController
{
    var delete_button:UIButton!;
    var copy_button:UIButton!;
    
    override func viewDidLoad() {
        

        super.viewDidLoad();
        self.label.removeFromSuperview();
        self.view.backgroundColor = UIColor.whiteColor();
        
        let button_width:CGFloat = self.view.bounds.width * 0.25;
        let button_margin:CGFloat = (self.view.bounds.width - (2.0 * button_width)) / 3.0;
        let button_height:CGFloat = self.view.bounds.height * 0.7;
        let button_y:CGFloat = self.view.bounds.height * 0.15;
        
        delete_button = UIButton(frame: CGRect(x: button_margin, y: button_y, width: button_width, height: button_height));
        delete_button.backgroundColor = SOFT_RED;
        delete_button.layer.cornerRadius = delete_button.bounds.height * 0.2;
        delete_button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        delete_button.setTitle("DELETE", forState: UIControlState.Normal);
        delete_button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted);
        self.view.addSubview(delete_button);
        
        copy_button = UIButton(frame: CGRect(x: delete_button.frame.maxX + button_margin, y: button_y, width: button_width, height: button_height));
        copy_button.backgroundColor = SOFT_GREEN;
        copy_button.layer.cornerRadius = delete_button.layer.cornerRadius;
        copy_button.setTitle("COPY", forState: UIControlState.Normal);
        copy_button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        copy_button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted);
        self.view.addSubview(copy_button);
        
    }
    
    override func show(text:String)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = self.in_frame;
        });

    }
}