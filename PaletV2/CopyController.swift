//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//


import Foundation
import UIKit

class CopyController:AuxillaryController, UITableViewDataSource
{
    var table:UITableView!;
    var selected_label:UIView!;
    var exit_button:ExitButton!;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        let table_height:CGFloat = super_view.bounds.height * 0.4; // new height
        let label_height:CGFloat = 44.0;
        let height:CGFloat = label_height + table_height;
        self.in_frame = CGRect(x: 0.0, y: nav_controller.view.bounds.height - height, width: super_view.bounds.width, height: height);
        super_view.frame = in_frame;
        
        super_view.backgroundColor = UIColor.orangeColor();
        place_right();
        
        table = UITableView(frame: super_view.bounds);
        
        
        selected_label = UIView(frame: CGRect(x: 0.0, y: 0.0, width: super_view.bounds.width, height: label_height));
        selected_label.backgroundColor = UIColor.lightGrayColor();
        super_view.addSubview(selected_label);
        
        //
        exit_button = ExitButton();
        let exit_dim:CGFloat = selected_label.bounds.height * 0.7;
        let exit_margin:CGFloat = (selected_label.bounds.height - exit_dim) * 0.5;
        let exit_x:CGFloat = selected_label.bounds.width - exit_dim - exit_margin;
        
        exit_button.frame = CGRect(x: exit_x, y: exit_margin, width: exit_dim, height: exit_dim);
        exit_button.set_highlight_color(LIGHT_GRAY);
        exit_button.set_unhighlight_color(SOFT_RED);
        exit_button.set_image_color(UIColor.blackColor());
        exit_button.set_path_width(2.0);
        exit_button.addTarget(self, action: "hide", forControlEvents: UIControlEvents.TouchDown);
        selected_label.addSubview(exit_button);
        
        let table_frame = CGRect(x: 0.0, y: label_height, width: super_view.bounds.width, height: super_view.bounds.height - label_height);
        table = UITableView(frame: table_frame, style: UITableViewStyle.Plain);
        super_view.addSubview(table);
        table.delegate = nav_controller.palet_controller;
        table.dataSource = self;
        table.backgroundColor = WOLF_GRAY;
        table.separatorStyle = UITableViewCellSeparatorStyle.None;
        super_view.addSubview(table);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: cell.bounds.height);
        if((indexPath.row % 2) == 0)
        {
            cell.backgroundColor = WOLF_GRAY;
        }
        else
        {
            cell.backgroundColor = DARK_GRAY;
        }
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.text = nav_controller.palet_controller.palette_names[indexPath.row];
        
        let copy_dim:CGFloat = cell.bounds.height * 0.7;
        let copy_margin:CGFloat = (cell.bounds.height - copy_dim) * 0.5;
        let copy_x:CGFloat = cell.bounds.width - copy_dim - copy_margin;
        
        let copy_button = SaveButton();
        copy_button.frame = CGRect(x: copy_x, y: copy_margin, width: copy_dim, height: copy_dim);
        copy_button.set_highlight_color(LIGHT_GRAY);
        copy_button.set_unhighlight_color(SOFT_ORANGE);
        copy_button.set_image_color(UIColor.blackColor());
        copy_button.set_path_width(2.0);
        copy_button.tag = indexPath.row;
        copy_button.addTarget(self, action: "copy_colors:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.addSubview(copy_button);
        
        
        // add button to view palets
        let view_button = ViewButton();
        let view_dim = copy_dim;
        view_button.tag = indexPath.row;
        view_button.frame = CGRect(x: copy_button.frame.origin.x - (copy_margin * 2.0) - copy_dim, y: copy_margin, width: view_dim, height: view_dim);
        view_button.set_highlight_color(LIGHT_GRAY);
        view_button.set_unhighlight_color(SOFT_GREEN);
        view_button.tag = indexPath.row;
        view_button.addTarget(nav_controller.view_palet_controller, action: "set_name:", forControlEvents: UIControlEvents.TouchUpInside);
        view_button.addTarget(nav_controller, action: "view_colors", forControlEvents: UIControlEvents.TouchUpInside);
        view_button.addTarget(self, action: "hide", forControlEvents: UIControlEvents.TouchUpInside);
        cell.addSubview(view_button);
        return cell;
        
    }
    
    func copy_colors(sender:UIButton)
    {
        let palet = nav_controller.palet_controller.palette_names[sender.tag];
        let checked_colors = nav_controller.favorites_controller.sorted_colors;
        let colors = nav_controller.favorites_controller.colors;
        for(var i = 0; i < checked_colors.count; ++i)
        {
            let index = checked_colors[i];
            let current_color = colors[index];
            
            // check if color is already in palet, if not add it
            if(fetch_color(current_color, group: palet)!.count > 0)
            {
                print("color already in " + palet);
            }
            else
            {
                store_color(current_color, group: palet);
                print("storing color");
            }
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(fetch_palets()?.count != nil)
        {
            return fetch_palets()!.count;
        }
        else
        {
            print("Error unable to retrieve palets");
        }
        return 0;
    }
    
    func hide()
    {
        nav_controller.favorites_controller.maximize_table(0.25);
        place_right();
        
    }
    
    func show()
    {
        nav_controller.favorites_controller.minimize_table(0.25);
        show(0.5);
    }
    
    
}