//
//  ViewController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/15/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import UIKit

class NavController: UIViewController
{

    let picker_controller = PickerController();
    let palet_controller = PaletController();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(picker_controller.view);
        self.view.addSubview(palet_controller.view);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

}

class PickerController: UIViewController {
    
    let NUM_COMPONENTS = 3;
    var super_view:UIView!;
    var color_view:UIView!;
    var rgb_label:UILabel!;
    //var hex_label:UILabel!;
    var current_color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0);
    
    // buttons
    var favorite_button = UIButton();
    var add_button = UIButton();
    
    // sliders
    var sliders = [UISlider(), UISlider(), UISlider()];
    
    // labels
    var labels = [UILabel(), UILabel(), UILabel()];
    var label_txt = ["R", "G", "B"];
    var rgb_colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()];
    
    
    // shade slider
    var shade_slider:UISlider!;
    var gradient_view:UIView!;
    var gradient:CAGradientLayer = CAGradientLayer();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // should take up top 40% of screen
        super_view = self.view;
        var height:CGFloat = super_view.bounds.height * 0.6;
        super_view.frame = CGRect(x: 0.0, y: 0.0, width: super_view.bounds.width, height: height);
        
        // configure color view
        var color_width:CGFloat = super_view.bounds.width * 0.8;
        var color_offset_x:CGFloat = super_view.bounds.width * 0.05;
        var color_offset_y:CGFloat = super_view.bounds.width * 0.15;
        var color_height:CGFloat = super_view.bounds.height * 0.5;
        color_view = UIView(frame: CGRect(x: color_offset_x, y: color_offset_y, width: color_width, height: color_height));
        color_view.backgroundColor = UIColor.grayColor();
        color_view.layer.borderWidth = 1.0;
        super_view.addSubview(color_view);
        
        // configure rgb label
        var rgb_offx:CGFloat = super_view.bounds.width * 0.23;
        var rgb_offy:CGFloat = super_view.bounds.height * 0.00;
        var rgb_width:CGFloat = super_view.bounds.width * 0.6;
        var rgb_height:CGFloat = super_view.bounds.height * 0.2;
        rgb_label = UILabel(frame:CGRect(x: rgb_offx, y: rgb_offy, width: rgb_width, height: rgb_height));
        rgb_label.text = "rgb(128, 128, 128)     #808080";
        rgb_label.font = UIFont.systemFontOfSize(16.0);
        super_view.addSubview(rgb_label);
        
        // configure hex label
        var hex_offx:CGFloat = rgb_label.frame.origin.x + rgb_label.frame.width + super_view.bounds.width * 0.06;
        var hex_offy:CGFloat = rgb_label.frame.origin.y;
        var hex_width:CGFloat = super_view.bounds.width * 0.35;
        var hex_height:CGFloat = rgb_label.bounds.height
        
        var button_color = UIColor.blackColor();
        var button_text_color = UIColor.whiteColor();
        var button_border_color = UIColor.whiteColor().CGColor;
        
        // configure favorite button
        var but_width:CGFloat = color_view.bounds.width * 0.45;
        var but_height:CGFloat = color_view.bounds.height * 0.25;
        var but_margin:CGFloat = (color_view.bounds.width - (2.0 * but_width)) / 3.0;
        var but_offset_y:CGFloat = color_view.bounds.height - but_height - but_margin;
        
        favorite_button = UIButton(frame: CGRect(x: but_margin, y: but_offset_y, width: but_width, height: but_height));
        favorite_button.backgroundColor = button_color;
        favorite_button.setTitleColor(button_text_color, forState: UIControlState.Normal);
        favorite_button.setTitle("FAVORITE", forState: UIControlState.Normal);
        favorite_button.titleLabel?.font = UIFont.systemFontOfSize(13.0);
        favorite_button.layer.cornerRadius = favorite_button.bounds.width * 0.05;
        favorite_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        favorite_button.addTarget(self, action: "add_favorite", forControlEvents: UIControlEvents.TouchUpInside);
        favorite_button.layer.borderWidth = 1.0;
        favorite_button.layer.borderColor = button_border_color;
        color_view.addSubview(favorite_button);
        
        // configure palette button
        var add_width:CGFloat = favorite_button.bounds.width;
        var add_height:CGFloat = favorite_button.bounds.height;
        var add_offset_x:CGFloat = favorite_button.frame.origin.x + but_width + but_margin;
        var add_offset_y:CGFloat = but_offset_y;
        
        add_button = UIButton(frame: CGRect(x: add_offset_x, y: add_offset_y, width: add_width, height: add_height));
        add_button.backgroundColor = button_color;
        add_button.setTitleColor(button_text_color, forState: UIControlState.Normal);
        add_button.setTitle("ADD TO PALETTE", forState: UIControlState.Normal);
        add_button.titleLabel?.font = UIFont.systemFontOfSize(13.0);
        add_button.layer.cornerRadius = add_button.bounds.width * 0.05;
        add_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        add_button.addTarget(self, action: "add_to_palette", forControlEvents: UIControlEvents.TouchUpInside);
        add_button.layer.borderWidth = 1.0;
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
            var offset_y:CGFloat = color_view.frame.maxY + comp_margin + ((comp_margin + comp_dim) * CGFloat(i));
            labels[i] = UILabel(frame: CGRect(x: comp_margin, y: offset_y, width: comp_dim, height: comp_dim));
            labels[i].layer.cornerRadius = comp_dim * 0.5;
            labels[i].text = label_txt[i];
            labels[i].layer.borderWidth = 1.0;
            labels[i].textAlignment = NSTextAlignment.Center;
            super_view.addSubview(labels[i]);
            
            // configure sliders to right of labels
            sliders[i] = UISlider(frame: CGRect(x: comp_margin + comp_dim, y: labels[i].frame.origin.y, width: slider_width, height: slider_height));
            super_view.addSubview(sliders[i]);
            
            var tracker_image:UIImage = UIImage(named: "thumb_long.pdf")!.stretchableImageWithLeftCapWidth(10, topCapHeight: 0);
            sliders[i].setThumbImage(tracker_image, forState: UIControlState.Normal);
            sliders[i].minimumTrackTintColor = rgb_colors[i];
            sliders[i].maximumValue = 1.0;
            sliders[i].minimumValue = 0.0;
            sliders[i].value = 0.5;
            sliders[i].addTarget(self, action: "change_color", forControlEvents: UIControlEvents.ValueChanged);
            
            // configure shade slider
            var shade_width:CGFloat = sliders[0].bounds.width;
            var shade_offset_x:CGFloat = color_view.bounds.maxX;
            var shade_offset_y:CGFloat = super_view.bounds.height * 0.05;
            var shade_height:CGFloat = color_view.frame.maxY - shade_offset_y; // 2.0 accounts for border

    
            shade_slider = UISlider();
            // flip to vertical position

            var trans = CGAffineTransformMakeRotation(CGFloat(M_PI * 0.5));
            shade_slider.transform = trans;
            shade_slider.frame = CGRect(x: color_view.frame.maxX + 10.0, y: shade_offset_y, width: 40.0, height: shade_height);

            shade_slider.value = 0.5;
            shade_slider.minimumTrackTintColor = UIColor.clearColor();
            shade_slider.maximumTrackTintColor = UIColor.clearColor();
            shade_slider.backgroundColor = UIColor.whiteColor();
            
            // set slider thumb image
            shade_slider.setThumbImage(get_color_image(UIColor.blackColor(), 40.0, 6.0), forState: UIControlState.Normal);
            shade_slider.addTarget(self, action: "adjust_shade", forControlEvents: UIControlEvents.ValueChanged);
            shade_slider.addTarget(self, action: "change_color", forControlEvents: UIControlEvents.TouchUpInside);
            
            
            // create gradient layer
            var gradient_margin:CGFloat = shade_slider.bounds.height * 0.2;
            var gradient_height:CGFloat = shade_slider.bounds.height - (2.0 * gradient_margin);
            var test_gradient = CAGradientLayer();
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
        println("Adding Favorite");
    }
    
    func add_to_palette()
    {
        println("Adding To Palet");
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
                var t_val:Float = (0.5 - shade_slider.value) / 0.5;
                println(t_val);
                sliders[i].value = Float(rgb_comps[i]) * (1.0 - t_val);
            }
            // add white
            else
            {
                var t_val:Float = (shade_slider.value - 0.5) / 0.5;
                println(t_val);
                sliders[i].value = ((1.0 - t_val) * Float(rgb_comps[i])) + t_val;
            }
        }
        var red:CGFloat = CGFloat(sliders[0].value);
        var green:CGFloat = CGFloat(sliders[1].value);
        var blue:CGFloat = CGFloat(sliders[2].value);
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
        var red:CGFloat = CGFloat(sliders[0].value);
        var green:CGFloat = CGFloat(sliders[1].value);
        var blue:CGFloat = CGFloat(sliders[2].value);
        color_view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        current_color = color_view.backgroundColor!;
        gradient.colors = [UIColor.blackColor().CGColor, color_view.backgroundColor!.CGColor, UIColor.whiteColor().CGColor];
        update_code();
    }
    
    func update_code()
    {
        // update rgb
        var r:Int = Int(255.0 * sliders[0].value);
        var g:Int = Int(255.0 * sliders[1].value);
        var b:Int = Int(255.0 * sliders[2].value);
        rgb_label.text = "(" + String(r) + ", " + String(g) + ", " + String(b) + ")";
        
        // get fill
        let comps = [r,g,b];
        var fill = 0;
        for(var i = 0; i < NUM_COMPONENTS; ++i)
        {
            if(comps[i] < 10)
            {
                fill += 2;
            }
            else if(comps[i] < 100)
            {
                ++fill;
            }
        }
        println(fill);
        for(var i = 0; i < fill; ++i)
        {
            rgb_label.text = rgb_label.text! + "  ";
        }
        var hex:String = NSString(format:"     #%02X%02X%02X", r, g, b) as String;
        rgb_label.text = rgb_label.text! + hex;
        
        // update hex string
        //hex_label.text = "";//NSString(format:"#%02X%02X%02X", r, g, b) as String;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

