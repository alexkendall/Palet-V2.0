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
    let menu_controller = SelController();
    let favorites_controller = FavoritesController();
    let view_palet_controller = ViewPaletController();
    let new_palet_controller = NewPaletController();
    var controller_label:UILabel!;
    var nav_but:NavButton!;
    let notification_controller = NotificationController();
    let operation_controller = OperationController();
    let copy_controller = CopyController();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setDeviceInfo();
        
        if(DEVICE_VERSION == DEVICE_TYPE.IPAD)
        {
            nav_but = NavButton(frame: CGRect(x: view.bounds.width * 0.05 - 3.0, y: 15.0, width:  view.bounds.width * 0.075, height:  view.bounds.width * 0.075));
        }
        else
        {
            nav_but = NavButton(frame: CGRect(x: view.bounds.width * 0.05 - 3.0, y: 15.0, width:  view.bounds.width * 0.1, height:  view.bounds.width * 0.1));
        }
        
        self.view.addSubview(nav_but);
        self.view.addSubview(menu_controller.view);
        self.view.addSubview(picker_controller.view);
        self.view.addSubview(favorites_controller.view);
        self.view.addSubview(view_palet_controller.view);
        self.view.addSubview(palet_controller.view);
        self.view.addSubview(new_palet_controller.view);
        self.view.addSubview(notification_controller.view);
        self.view.addSubview(operation_controller.view);
        self.view.addSubview(copy_controller.view);
        operation_controller.delete_button.addTarget(favorites_controller, action: "delete_colors", forControlEvents: UIControlEvents.TouchUpInside);
        operation_controller.copy_button.addTarget(copy_controller, action: "show", forControlEvents: UIControlEvents.TouchUpInside);
        
        let label_width:CGFloat = self.view.bounds.width - nav_but.frame.maxX;
        let label_height:CGFloat = 40.0;
        let label_y:CGFloat = nav_but.frame.maxY - label_height + 3;
        
        setDeviceInfo();
        if(DEVICE_VERSION == DEVICE_TYPE.IPAD)
        {
            controller_label = UILabel(frame: CGRect(x: nav_but.frame.maxX - 28.0, y: label_y, width: label_width - 15.0, height: label_height));
        }
        else
        {
            controller_label = UILabel(frame: CGRect(x: nav_but.frame.maxX, y: label_y, width: label_width - 15.0, height: label_height));
        }
        controller_label.textAlignment = NSTextAlignment.Right;
        controller_label.text = "MENU";
        self.view.addSubview(controller_label);
        
        
        picker_controller.place_right()
        favorites_controller.place_right();
        view_palet_controller.place_right();
        palet_controller.place_right();
        new_palet_controller.place_right();
        nav_but.addTarget(self, action: "handle_selection", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func copy_favorites()
    {
        print("copying favorites");
    }
    
    func show_label(text:String)
    {
        controller_label.text = text;
        UIView.animateWithDuration(1.0, animations:
        {
            self.controller_label.alpha = 1.0;
        })
    }
    
    func hide_label()
    {
        UIView.animateWithDuration(0.3, animations:
            {
                self.controller_label.alpha = 0.0;
        })
    }
    
    func handle_selection()
    {
        picker_controller.place_right();
        favorites_controller.place_right();
        view_palet_controller.place_right();
        palet_controller.place_right();
        new_palet_controller.place_right();
        menu_controller.show(0.5);
        show_label("MENU");
        nav_but.toggle_on();
        
    }
    
    func show_picker()
    {
        
        menu_controller.place_left();
        picker_controller.show(0.5);
        palet_controller.show(0.5);
        hide_label();
        nav_but.toggle_off();
    }
    
    func show_favorites()
    {
        menu_controller.place_left();
        favorites_controller.show(0.5);
        show_label("FAVORITES");
        nav_but.toggle_off();
    }
    
    func view_palet()
    {
        
        menu_controller.place_left();
        view_palet_controller.show(0.5);
        let name = view_palet_controller.palet_name;
        if(name == "")
        {
            show_label("unselected");
        }
        else
        {
            show_label(name);
        }
        nav_but.toggle_off();
        
    }
    
    func view_colors()
    {
        print(view_palet_controller.palet_name);
        
        show_label(view_palet_controller.palet_name);
        view_palet_controller.color_colection.reloadData();
        picker_controller.place_right();
        favorites_controller.place_right();
        view_palet_controller.show(0.5);
        palet_controller.place_right();
        new_palet_controller.place_right();
        nav_but.toggle_off();
    }
    
    func new_palet()
    {
        menu_controller.place_left();
        new_palet_controller.show(0.5);
        show_label("PALETTES");
        nav_but.toggle_off();
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}