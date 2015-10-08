//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//


import Foundation
import UIKit

class NewPaletController:AuxillaryController, UITextFieldDelegate
{
    var selected_index:Int = -1;
    var new_palet_container:AnimatedView!;
    var margin:CGFloat = 0.0;
    var table:UITableView!;
    var large_controller_frame:CGRect!;
    var small_controller_frame:CGRect!;
    var out_controller_frame:CGRect!;
    var add_palet_container:UIView!;
    var text_entry:TextField!;
    var add_button:AddButton!;
    let INIT_ENTRY = "ENTER NAME";
    let ERROR_ENTRY = "NAME CANNOT BE BLANK";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        margin = super_view.bounds.width * 0.05;
        
        // create container where user enters text to create a new palet
        let container_height:CGFloat = super_view.bounds.height * 0.15;
        let container_width:CGFloat = super_view.bounds.width - (2.0 * margin);
        add_palet_container = UIView(frame: CGRect(x: margin + 0.5, y: margin, width: container_width, height: container_height));
        add_palet_container.backgroundColor = WOLF_GRAY;
        super_view.addSubview(add_palet_container);
        
        // configure text field
        let text_height:CGFloat = add_palet_container.bounds.height * 0.33;
        let text_width:CGFloat = add_palet_container.bounds.width * 0.7;
        text_entry = TextField(frame:CGRect(x: margin, y: text_height, width: text_width, height: text_height));
        text_entry.backgroundColor = UIColor.whiteColor();
        text_entry.delegate = self;
        text_entry.text = INIT_ENTRY;
        text_entry.textColor = UIColor.grayColor();
        add_palet_container.addSubview(text_entry);
        
        // configure add button
        let add_dim:CGFloat = text_height;
        let add_margin:CGFloat = ((add_palet_container.bounds.width - text_entry.bounds.width) * 0.5) - add_dim;
        add_button = AddButton(frame: CGRect(x: text_entry.frame.maxX + add_margin, y: text_height, width: add_dim, height: add_dim));
        add_button.set_highlight_color(UIColor.whiteColor());
        add_button.set_unhighlight_color(SOFT_GREEN);

        add_button.set_path_width(2.0);
        add_button.set_border_width(2.0);
        add_button.addTarget(self, action: "enter_palet", forControlEvents: UIControlEvents.TouchUpInside);
        add_button.addTarget(self, action: "textFieldShouldReturn:", forControlEvents: UIControlEvents.TouchUpInside)
        add_palet_container.addSubview(add_button);
        
        
        // configure table view
        table = UITableView(frame:CGRect(x: margin, y: add_palet_container.frame.maxY, width: add_palet_container.bounds.width, height:super_view.bounds.height - add_palet_container.bounds.height - (2.0 * margin)));
        
        table.backgroundColor = LIGHT_GRAY;
        table.layer.borderWidth = 1.0;
        super_view.addSubview(table);
        
        // table appearance
        table.separatorStyle = UITableViewCellSeparatorStyle.None;
        table.dataSource = nav_controller.palet_controller;
        table.delegate = nav_controller.palet_controller;
        

    }
    
    // start text field delegate functions
    
    func textFieldDidBeginEditing(textField: UITextField) {
        text_entry.text = "";
        text_entry.textColor = UIColor.blackColor();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        text_entry.resignFirstResponder();
        enter_palet();
        return true;
    }
    
    // end text field delegate functions
    
    func enter_palet()
    {
        if((text_entry.text != "") && (text_entry.text != ERROR_ENTRY) && (text_entry.text != INIT_ENTRY))
        {
            //nav_controller.palet_controller.palette_names.append(text_entry.text!);
            store_palet(text_entry.text!);
            
            self.table.reloadData();
            nav_controller.palet_controller.table.reloadData();
            text_entry.text = INIT_ENTRY;
        }
        else
        {
            text_entry.text = ERROR_ENTRY;
        }
        text_entry.textColor = UIColor.grayColor();
    }
    
    
    
    override func push_left(duration: NSTimeInterval) {
        super.push_left(duration);
        selected_index = -1;
        table.reloadData();
        text_entry.resignFirstResponder();
        
    }
    
    override func push_right(duration: NSTimeInterval) {
        super.push_right(duration);
        selected_index = -1;
        table.reloadData();
        text_entry.resignFirstResponder();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}