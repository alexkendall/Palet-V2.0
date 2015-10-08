//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class SelController:AuxillaryController
{
    var margin:CGFloat!;
    var nav:NavButton!;
    var back_view:UIView!;
    var label_texts = ["NEW PALETTE", "VIEW FAVORITES", "COLOR PICKER"];
    var colors = [SOFT_GREEN, SOFT_ORANGE, MAGENTA, LIGHT_BLUE, UIColor.yellowColor()];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        margin = super_view.bounds.width * 0.05;
        
        // configure back view
        back_view = UIView(frame: CGRect(x: margin, y: margin, width: super_view.frame.width - (2.0 * margin), height: (super_view.bounds.height - 2.0 * margin)));
        super_view.addSubview(back_view);
        
        // 
        let height:CGFloat = back_view.bounds.height * 1.0;
    
        
        // cofigure icon and labels
        let icon_dim:CGFloat = height / CGFloat(label_texts.count);
        let label_width:CGFloat = back_view.bounds.width - icon_dim;
        let label_height:CGFloat = icon_dim;

        
        for(var i = 0; i < label_texts.count; ++i)
        {
            let offset_y:CGFloat = (CGFloat(i) * icon_dim);
            let container_view = UIView(frame: CGRect(x: 0.0, y: offset_y, width: back_view.bounds.width + 2.0, height: icon_dim));
            container_view.layer.borderWidth = 1.0;
            container_view.layer.borderColor = UIColor.whiteColor().CGColor;
            container_view.backgroundColor = WOLF_GRAY;
            
            let scale:CGFloat = 0.5;
            let but_size:CGFloat = icon_dim * scale;
            let but_marg:CGFloat = (icon_dim - (but_size)) * 0.5;
            
            
            var icon_button:MenuButton!;
            
            if(i == 0)
            {
                icon_button = AddButton(frame: CGRect(x: but_marg * 0.5, y: but_marg, width: but_size, height: but_size));
                icon_button.set_path_width(3.0);
                icon_button.addTarget(nav_controller, action: "new_palet", forControlEvents: UIControlEvents.TouchUpInside);
                
            }
            else if(i == 1)
            {
                icon_button = FavoriteButton(frame: CGRect(x: but_marg * 0.5, y: but_marg, width: but_size, height: but_size));
                icon_button.set_path_width(3.0);
                
                icon_button.addTarget(nav_controller, action: "show_favorites", forControlEvents: UIControlEvents.TouchUpInside);
            }
            
            else if(i == 2)
            {
                icon_button = PickerButton(frame: CGRect(x: but_marg * 0.5, y: but_marg, width: but_size, height: but_size));
                icon_button.set_path_width(3.0);
                
                icon_button.addTarget(nav_controller, action: "show_picker", forControlEvents: UIControlEvents.TouchUpInside);
            }
            else
            {
                icon_button = MenuButton(frame: CGRect(x: but_marg * 0.5, y: but_marg, width: but_size, height: but_size));
            }
            
            icon_button.set_unhighlight_color(colors[i]);
            icon_button.set_highlight_color(UIColor.lightGrayColor());
            icon_button.set_border_color(UIColor.blackColor());
            icon_button.set_border_width(3.0);
            
            let label_margin:CGFloat = back_view.bounds.width * 0.05;
            let label:UILabel = UILabel(frame: CGRect(x: icon_button.frame.maxX + label_margin, y: 0.0, width: label_width, height: label_height));
            label.textColor = UIColor.whiteColor();
            label.text = label_texts[i];
            label.font = UIFont(name: "Helvetica Neue", size: 17.0);
            container_view.addSubview(icon_button);
            container_view.addSubview(label);
            back_view.addSubview(container_view);
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}