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
    var nav_but = NavButton(frame: CGRect(x: 15.0, y: 15.0, width: 40.0, height: 40.0));
    let notification_controller = NotificationController();
    let operation_controller = OperationController();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(nav_but);
        self.view.addSubview(menu_controller.view);
        self.view.addSubview(picker_controller.view);
        self.view.addSubview(favorites_controller.view);
        self.view.addSubview(view_palet_controller.view);
        self.view.addSubview(palet_controller.view);
        self.view.addSubview(new_palet_controller.view);
        self.view.addSubview(notification_controller.view);
        self.view.addSubview(operation_controller.view);
        operation_controller.delete_button.addTarget(favorites_controller, action: "delete_colors", forControlEvents: UIControlEvents.TouchUpInside);
        
        let label_width:CGFloat = self.view.bounds.width - nav_but.frame.maxX;
        controller_label = UILabel(frame: CGRect(x: nav_but.frame.maxX, y: 15.0, width: label_width - 15.0, height: 40.0));
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
        
    }
    
    func show_picker()
    {
        
        menu_controller.place_left();
        picker_controller.show(0.5);
        palet_controller.show(0.5);
        hide_label();
    }
    
    func show_favorites()
    {
        menu_controller.place_left();
        favorites_controller.show(0.5);
        show_label("FAVORITES");
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
    }
    
    func new_palet()
    {
        menu_controller.place_left();
        new_palet_controller.show(0.5);
        show_label("PALETS");
    }
    
    func search_color()
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}