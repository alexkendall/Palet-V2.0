//
//  ViewController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/15/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import UIKit

class PickerController:AuxillaryController, UITextFieldDelegate {
    
    let NUM_COMPONENTS = 3;
    var color_view:AnimatedView!
    var rgb_label:AnimatedLabel!
    var current_color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0);
    
    // buttons
    var favorite_button:AnimatedButton!
    var add_button:AnimatedButton!
    
    // sliders
    var sliders = [AnimatedSlider(), AnimatedSlider(),AnimatedSlider()];
    var steppers = [Stepper(), Stepper(), Stepper()];
    
    // labels
    var labels = [AnimatedLabel(), AnimatedLabel(), AnimatedLabel()];
    var label_txt = ["R", "G", "B"];
    var rgb_colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()];
    
    
    // shade slider
    var shade_slider:AnimatedSlider!;
    var gradient_view:AnimatedView!;
    var gradient:CAGradientLayer = CAGradientLayer();
    
    var selected_palet:String = "";
    
    // text fielf for entering code directly
    var code_entry_field:UITextField!;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // should take up top 40% of screen
        let height:CGFloat = super_view.bounds.height * 0.65;
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
        
        // set up for direct hex code entry
        let margin:CGFloat = super_view.bounds.height * 0.05;
        let entry_y:CGFloat = color_view.frame.maxY + margin;
        let entry_height:CGFloat = super_view.bounds.height * 0.07;
        
        // configure label for prompt
        let hex_label = UILabel();
        hex_label.text = "HEX";
        hex_label.sizeToFit();
        hex_label.frame = CGRect(x: margin, y: entry_y, width: hex_label.frame.width, height: entry_height);
        super_view.addSubview(hex_label);
        
        // configre text entry
        let entry_width:CGFloat = super_view.bounds.width - hex_label.frame.maxX - ( 2.0 * margin);
        code_entry_field = TextField(frame:CGRect(x: hex_label.frame.maxX + margin, y: entry_y, width: entry_width, height: entry_height));
        code_entry_field.backgroundColor = UIColor.lightGrayColor();
        code_entry_field.layer.borderWidth = 1.0;
        code_entry_field.delegate = self;
        code_entry_field.autocapitalizationType = UITextAutocapitalizationType.AllCharacters;
        code_entry_field.text = "#808080";
        super_view.addSubview(code_entry_field);
        
        
        // stepper dimensions
        let stepper_width:CGFloat = super_view.bounds.width * 0.1;
        let stepper_height:CGFloat = stepper_width;
        
        // configure rgb labels
        let comp_margin:CGFloat = color_view.frame.origin.x;
        let comp_dim:CGFloat = super_view.bounds.width * 0.075;
        let slider_width:CGFloat = super_view.bounds.width - (comp_margin * 2.0) - comp_dim - stepper_width;
        print(super_view.bounds.width);
        let slider_height:CGFloat = comp_dim;
        
        for(var i = 0; i < NUM_COMPONENTS; ++i)
        {
            // configure labels
            let offset_y:CGFloat = code_entry_field.frame.maxY + comp_margin + ((comp_margin + comp_dim) * CGFloat(i));
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
            
            // configure stepper
            let stepper_offset:CGFloat = 0.5 * (stepper_height - labels[i].bounds.height);
            steppers[i] = Stepper(frame: CGRect(x: sliders[i].frame.maxX, y: sliders[i].frame.origin.y - stepper_offset, width: stepper_width, height: stepper_height));
                print(sliders[i].bounds.width);
            super_view.addSubview(steppers[i]);
            steppers[i].incr_button.addTarget(self, action: "increment:", forControlEvents: UIControlEvents.TouchDown);
            steppers[i].decr_button.addTarget(self, action: "decrement:", forControlEvents: UIControlEvents.TouchDown);
            steppers[i].incr_button.tag = i;
            steppers[i].decr_button.tag = i;
        }
    }
    
    func increment(sender:UIButton)
    {
        let increment:Float = 1.0 / 255.0;
        sliders[sender.tag].value += increment;
        change_color();
    }
    
    
    func decrement(sender:UIButton)
    {
        let decrement:Float = 1.0 / 255.0;
        sliders[sender.tag].value -= decrement;
        change_color();
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
        code_entry_field.text = hex;
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
    
    // textfield delegate --------------------------------------------------------------------------------------------------
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("began editing");
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("did end editing");
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("text field should return...");
        
        let hex_code = code_entry_field.text;
        if(is_valid(hex_code!))
        {
            print("valid text... will change");
            color_view.backgroundColor = get_color(hex_code!);
       
            var r:CGFloat = 0.0;
            var g:CGFloat = 0.0;
            var b:CGFloat = 0.0;
            var a:CGFloat = 0.0;
            color_view.backgroundColor!.getRed(&r, green: &g, blue: &b, alpha: &a);
            sliders[0].value = Float(r);
            sliders[1].value = Float(g);
            sliders[2].value = Float(b);            
            update_code();
            gradient.colors = [UIColor.blackColor().CGColor, color_view.backgroundColor!.CGColor, UIColor.whiteColor().CGColor];
            
        }
        else
        {
            change_color();
        }
        
        code_entry_field.resignFirstResponder();
        
        return true;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("text field should begin editing");
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("text field should return");
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("text field should end editing");
        return true;
    }
    
    // end delegate --------------------------------------------------------------------------------------------------------
  
    
}