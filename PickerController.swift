//
//  ViewController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/15/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import UIKit

class PickerController:AuxillaryController {
    
    let NUM_COMPONENTS = 3;
    var color_view:AnimatedView!
    var rgb_label:AnimatedLabel!
    var current_color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0);
    
    // buttons
    var favorite_button:AnimatedButton!
    var add_button:AnimatedButton!
    
    // sliders
    var sliders = [AnimatedSlider(), AnimatedSlider(),AnimatedSlider()];
    
    // labels
    var labels = [AnimatedLabel(), AnimatedLabel(), AnimatedLabel()];
    var label_txt = ["R", "G", "B"];
    var rgb_colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()];
    
    
    // shade slider
    var shade_slider:AnimatedSlider!;
    var gradient_view:AnimatedView!;
    var gradient:CAGradientLayer = CAGradientLayer();
    
    var selected_palet:String = "";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // should take up top 40% of screen
        let height:CGFloat = super_view.bounds.height * 0.5;
        self.in_frame = CGRect(x: 0.0, y: super_view.frame.origin.y, width: super_view.bounds.width, height: height);
        self.left_frame = CGRect(x: self.view.frame.width, y: self.view.frame.origin.y, width: self.view.frame.width, height: height);
        self.right_frame = CGRect(x: self.view.frame.width, y: self.view.frame.origin.y, width: self.view.frame.width, height: height);
        super_view.frame = self.right_frame;

        // configure color view
        let color_width:CGFloat = super_view.bounds.width * 0.8;
        let color_offset_x:CGFloat = super_view.bounds.width * 0.05;
        let color_offset_y:CGFloat = 0.0;
        let color_height:CGFloat = super_view.bounds.height * 0.5;
        
        // configure color animated frames
        let color_in_frame = CGRect(x: color_offset_x, y: color_offset_y, width: color_width, height: color_height)
        let color_out_frame = CGRect(x: super_view.bounds.width, y: color_offset_y, width: color_width, height: color_height)
        color_view = AnimatedView(in_frame: color_in_frame, out_frame: color_out_frame);
        
        color_view.backgroundColor = UIColor.grayColor();
        color_view.layer.borderWidth = 1.0;
        super_view.addSubview(color_view);
        
        // configure rgb label
        let rgb_height:CGFloat = super_view.bounds.height * 0.1;
        let rgb_offx:CGFloat = super_view.bounds.width * 0.23;
        let rgb_offy:CGFloat = -rgb_height;
        let rgb_width:CGFloat = super_view.bounds.width * 0.6;

        
        // configure rgb in frame
        let rgb_in_frame = CGRect(x: rgb_offx, y: rgb_offy, width: rgb_width, height: rgb_height);
        let rgb_out_frame = CGRect(x: rgb_offx, y: -rgb_height, width: rgb_width, height: rgb_height);
        rgb_label = AnimatedLabel(in_frame: rgb_in_frame, out_frame: rgb_out_frame);
        
        rgb_label.text = "#808080  rgb(128, 128, 128)";
        rgb_label.font = UIFont.systemFontOfSize(16.0);
        super_view.addSubview(rgb_label);
        
        
        let button_color = UIColor.blackColor();
        let button_text_color = UIColor.whiteColor();
        let button_border_color = UIColor.clearColor().CGColor;
        
        // configure favorite button
        let but_width:CGFloat = color_view.bounds.width * 0.45;
        let but_height:CGFloat = color_view.bounds.height * 0.25;
        let but_margin:CGFloat = (color_view.bounds.width - (2.0 * but_width)) / 3.0;
        let but_offset_y:CGFloat = color_view.bounds.height - but_height - but_margin;
        
        // favorite button in frame
        let favorite_in_frame = CGRect(x: but_margin, y: but_offset_y, width: but_width, height: but_height);
        let favorite_out_frame = CGRect(x: but_margin, y: but_offset_y, width: but_width, height: but_height);
        favorite_button = AnimatedButton(in_frame: favorite_in_frame, out_frame: favorite_out_frame);
        favorite_button.backgroundColor = button_color;
        favorite_button.setTitleColor(button_text_color, forState: UIControlState.Normal);
        favorite_button.setTitle("FAVORITE", forState: UIControlState.Normal);
        favorite_button.titleLabel?.font = UIFont.systemFontOfSize(13.0);
        favorite_button.layer.cornerRadius = favorite_button.bounds.width * 0.05;
        favorite_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        favorite_button.addTarget(self, action: "add_favorite", forControlEvents: UIControlEvents.TouchUpInside);
        favorite_button.layer.borderWidth = 2.0;
        favorite_button.layer.borderColor = button_border_color;
        color_view.addSubview(favorite_button);
        
        // configure palette button
        let add_width:CGFloat = favorite_button.bounds.width;
        let add_height:CGFloat = favorite_button.bounds.height;
        let add_offset_x:CGFloat = favorite_button.frame.origin.x + but_width + but_margin;
        let add_offset_y:CGFloat = but_offset_y;
        
        // add in frame
        let add_in_frame = CGRect(x: add_offset_x, y: add_offset_y, width: add_width, height: add_height);
        let add_out_frame = CGRect(x: add_offset_x, y: add_offset_y, width: add_width, height: add_height);
        add_button = AnimatedButton(in_frame: add_in_frame, out_frame: add_out_frame);
        add_button.backgroundColor = button_color;
        add_button.setTitleColor(button_text_color, forState: UIControlState.Normal);
        add_button.setTitle("ADD TO PALETTE", forState: UIControlState.Normal);
        add_button.titleLabel?.font = UIFont.systemFontOfSize(13.0);
        add_button.layer.cornerRadius = add_button.bounds.width * 0.05;
        add_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        add_button.addTarget(self, action: "add_to_palette", forControlEvents: UIControlEvents.TouchUpInside);
        add_button.layer.borderWidth = 2.0;
        add_button.layer.borderColor = button_border_color;
        color_view.addSubview(add_button);
        
        // configure rgb labels
        let comp_margin:CGFloat = color_view.frame.origin.x;
        let comp_dim:CGFloat = super_view.bounds.width * 0.075;
        let slider_width:CGFloat = super_view.bounds.width - (comp_margin * 2.0) - comp_dim;
        let slider_height:CGFloat = comp_dim;
        
        for(var i = 0; i < NUM_COMPONENTS; ++i)
        {
            // configure labels
            let offset_y:CGFloat = color_view.frame.maxY + comp_margin + ((comp_margin + comp_dim) * CGFloat(i));
            let label_in_frame = CGRect(x: comp_margin, y: offset_y, width: comp_dim, height: comp_dim);
            let label_out_frame = CGRect(x: super_view.bounds.width, y: offset_y, width: comp_dim, height: comp_dim);
            labels[i] = AnimatedLabel(in_frame: label_in_frame, out_frame: label_out_frame);
            labels[i].layer.cornerRadius = comp_dim * 0.5;
            labels[i].text = label_txt[i];
            labels[i].layer.borderWidth = 1.0;
            labels[i].textAlignment = NSTextAlignment.Center;
            super_view.addSubview(labels[i]);
            
            // configure sliders to right of labels
            let slider_in_frame = CGRect(x: comp_margin + comp_dim, y: labels[i].frame.origin.y, width: slider_width, height: slider_height);
            
            let slider_out_frame = CGRect(x: super_view.bounds.width, y: labels[i].frame.origin.y, width: slider_width, height: slider_height)
            
            sliders[i] = AnimatedSlider(in_frame: slider_in_frame, out_frame: slider_out_frame);
            super_view.addSubview(sliders[i]);
            
            let tracker_image:UIImage = UIImage(named: "thumb_long.pdf")!.stretchableImageWithLeftCapWidth(10, topCapHeight: 0);
            sliders[i].setThumbImage(tracker_image, forState: UIControlState.Normal);
            sliders[i].minimumTrackTintColor = rgb_colors[i];
            sliders[i].maximumValue = 1.0;
            sliders[i].minimumValue = 0.0;
            sliders[i].value = 0.5;
            sliders[i].addTarget(self, action: "change_color", forControlEvents: UIControlEvents.ValueChanged);
            
            // configure shade slider
            let shade_offset_y:CGFloat = color_view.frame.minY; //super_view.bounds.height * 0.05;
            let shade_height:CGFloat = color_view.frame.maxY - shade_offset_y; // 2.0 accounts for border
            
            shade_slider = AnimatedSlider();
            // flip to vertical position
            
            let trans = CGAffineTransformMakeRotation(CGFloat(M_PI * 0.5));
            shade_slider.transform = trans;
            
            shade_slider.frame = CGRect(x: color_view.frame.maxX + 10.0, y: shade_offset_y, width: 40.0, height: shade_height);
            shade_slider.in_frame = shade_slider.frame;
            shade_slider.out_frame = CGRect(x: shade_slider.frame.origin.x, y: -shade_slider.bounds.width, width: shade_slider.frame.width, height: shade_slider.frame.height);
            
            shade_slider.value = 0.5;
            shade_slider.minimumTrackTintColor = UIColor.clearColor();
            shade_slider.maximumTrackTintColor = UIColor.clearColor();
            shade_slider.backgroundColor = UIColor.whiteColor();
            
            // set slider thumb image
            shade_slider.setThumbImage(get_color_image(UIColor.blackColor(), height: 40.0, width: 6.0), forState: UIControlState.Normal);
            shade_slider.addTarget(self, action: "adjust_shade", forControlEvents: UIControlEvents.ValueChanged);
            shade_slider.addTarget(self, action: "change_color", forControlEvents: UIControlEvents.TouchUpInside);
            
            
            // create gradient layer
            let gradient_margin:CGFloat = shade_slider.bounds.height * 0.2;
            let gradient_height:CGFloat = shade_slider.bounds.height - (2.0 * gradient_margin);
            gradient.frame = CGRect(x: 0.0, y: gradient_margin, width: shade_slider.bounds.width, height: gradient_height);
            gradient.locations = [0, 0.5, 1.0];
            gradient.startPoint = CGPointMake(0.0, 0.0);
            gradient.endPoint = CGPointMake(1.0, 0.0);
            gradient.colors = [UIColor.blackColor().CGColor, color_view.backgroundColor!.CGColor, UIColor.whiteColor().CGColor];
            shade_slider.layer.addSublayer(gradient);
            super_view.addSubview(shade_slider);
    
            
        }
    }
    
    func add_favorite()
    {
        let color = self.color_view.backgroundColor;
        store_color(color!, group: FAVORITE_GROUP_NAME);
        nav_controller.favorites_controller.table.reloadData();
        nav_controller.notification_controller.show("Added " + get_hex(color!) +  " to favorites");

    }
    
    func add_to_palette()
    {
        if(selected_palet != "")
        {
            let color = self.color_view.backgroundColor;
            nav_controller.view_palet_controller.colors.append(color!);
            nav_controller.view_palet_controller.color_colection.reloadData();
            nav_controller.notification_controller.show("Added " + get_hex(color!) +  " to " + selected_palet);
            nav_controller.view_palet_controller.palet_name = selected_palet;
            store_color(color!, group: selected_palet);
        }
        else
        {
            nav_controller.notification_controller.show("You must select a palet.");
        }
    }
    
    func adjust_shade()
    {
        var r:CGFloat = 0.0;
        var g:CGFloat = 0.0;
        var b:CGFloat = 0.0;
        var a:CGFloat = 0.0;
        current_color.getRed(&r, green: &g, blue: &b, alpha: &a);
        let rgb_comps = [r,g,b];
        
        for(var i = 0; i < NUM_COMPONENTS; ++i)
        {
            // adjust rgb comonents accordingly
            if(shade_slider.value < 0.5)
                // add black
            {
                let t_val:Float = (0.5 - shade_slider.value) / 0.5;
                print(t_val);
                sliders[i].value = Float(rgb_comps[i]) * (1.0 - t_val);
            }
                // add white
            else
            {
                let t_val:Float = (shade_slider.value - 0.5) / 0.5;
                print(t_val);
                sliders[i].value = ((1.0 - t_val) * Float(rgb_comps[i])) + t_val;
            }
        }
        let red:CGFloat = CGFloat(sliders[0].value);
        let green:CGFloat = CGFloat(sliders[1].value);
        let blue:CGFloat = CGFloat(sliders[2].value);
        color_view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        update_code();
    }
    
    func reset_shade()
    {
        shade_slider.value = 0.5;
    }
    
    func change_color()
    {
        reset_shade();
        let red:CGFloat = CGFloat(sliders[0].value);
        let green:CGFloat = CGFloat(sliders[1].value);
        let blue:CGFloat = CGFloat(sliders[2].value);
        color_view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        current_color = color_view.backgroundColor!;
        gradient.colors = [UIColor.blackColor().CGColor, color_view.backgroundColor!.CGColor, UIColor.whiteColor().CGColor];
        update_code();
    }
    
    func update_code()
    {
        let hex = get_hex(color_view.backgroundColor!);
        let rgb = get_rgb(color_view.backgroundColor!);
        rgb_label.text = hex + "  " + rgb;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func push_left(duration: NSTimeInterval) {
        super.push_left(duration);
        selected_palet = "";
    }
    
    override func push_right(duration: NSTimeInterval) {
        super.push_right(duration);
        selected_palet = "";
    }
    
}



