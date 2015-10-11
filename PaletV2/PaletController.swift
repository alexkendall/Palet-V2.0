//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//


import Foundation
import UIKit

class PaletController:AuxillaryController, UITableViewDataSource, UITableViewDelegate
{
    
    var palette_names = [String]();
    
    
    var selected_index:Int = -1;
    
    // start data source ---------------------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell();
        cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: tableView.frame.width, height: cell.frame.height);
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        if((indexPath.row % 2) == 1)
        {
            cell.backgroundColor = DARK_GRAY;
        }
        else
        {
            cell.backgroundColor = WOLF_GRAY;
        }
        cell.textLabel?.text = palette_names[indexPath.row];
        
        if(indexPath.row == selected_index)
        {
            cell.textLabel?.textColor = UIColor.whiteColor();
        }
        else
        {
            cell.textLabel?.textColor = UIColor.lightGrayColor();
        }
        
        // add button to delete palets
        let delete_button = DeleteButton();
        let del_height:CGFloat = cell.bounds.height * 0.5;
        let del_margin:CGFloat = (cell.bounds.height - del_height) * 0.5;
        
        let del_x:CGFloat = cell.frame.width - del_height - del_margin;
        delete_button.frame = CGRect(x: del_x, y: del_margin, width: del_height, height: del_height);
        delete_button.set_highlight_color(LIGHT_GRAY);
        delete_button.set_unhighlight_color(SOFT_RED);
        delete_button.addTarget(self, action: "delete_palet:", forControlEvents: UIControlEvents.TouchUpInside);
        delete_button.tag = indexPath.row;
        cell.addSubview(delete_button);
        
        
        // add button to view palets
        let view_button = ViewButton();
        let view_height:CGFloat = cell.bounds.height * 0.5;
        let view_margin:CGFloat = (cell.bounds.height - del_height) * 0.5;
        let view_x:CGFloat = delete_button.frame.minX - (view_height * 1.5) - view_margin;
        view_button.tag = indexPath.row;
        view_button.frame = CGRect(x: view_x, y: view_margin, width: view_height, height: view_height);
        view_button.set_highlight_color(LIGHT_GRAY);
        view_button.set_unhighlight_color(SOFT_GREEN);
        view_button.tag = indexPath.row;
        view_button.addTarget(nav_controller.view_palet_controller, action: "set_name:", forControlEvents: UIControlEvents.TouchUpInside);
        view_button.addTarget(nav_controller, action: "view_colors", forControlEvents: UIControlEvents.TouchUpInside);
        cell.addSubview(view_button);
    
        let view = UIView();
        view.backgroundColor = UIColor.whiteColor();
        cell.selectedBackgroundView = view;
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        palette_names.removeAll(keepCapacity: true);
        let palets = fetch_palets();
        for(var i = 0; i < palets!.count; ++i)
        {
            palette_names.append(get_palet(palets![i]));
        }
        print(palette_names.count);
        return palette_names.count;
    }
    
    func set_name(sender:UIButton)
    {
        
    }
    
    // end data source --------------------------------------------------------------------
    
    
    // start delegate ---------------------------------------------------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("User selected row at index: " + String(indexPath.row));
        
        selected_label.text = "    Current Palette: " + palette_names[indexPath.row];
        selected_index = indexPath.row;
        nav_controller.picker_controller.selected_palet = palette_names[indexPath.row];
        table.reloadData();
        
    }
    
     // end delegate ----------------------------------------------------------------------
    
    
    var margin:CGFloat = 0.0;
    var table:UITableView!;
    var selected_label:UILabel!;
    var large_controller_frame:CGRect!;
    var small_controller_frame:CGRect!;
    var out_controller_frame:CGRect!;
    var add_palet_container:AnimatedView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get frame and bounds
        margin =  super_view.bounds.width * 0.05;
        let height:CGFloat = nav_controller.view.bounds.height - nav_controller.picker_controller.view.frame.maxY - margin;
        let offset_y:CGFloat = nav_controller.picker_controller.view.frame.maxY;
        let width:CGFloat = super_view.bounds.width;
 
        small_controller_frame = CGRect(x: 0.0, y: offset_y, width: width, height: height);
        super_view.frame = small_controller_frame;
        self.in_frame = small_controller_frame;
        
        // configure label
        selected_label = UILabel(frame: CGRect(x: margin + 0.5, y: 0.0, width: super_view.bounds.width - (2.0 * margin), height: 45.0));
        selected_label.text = "    Current Palette:";
        selected_label.backgroundColor = UIColor.blackColor();
        selected_label.textColor = UIColor.whiteColor();
        super_view.addSubview(selected_label);
        
        // configure table view
        table = UITableView(frame:CGRect(x: margin, y: selected_label.frame.maxY, width: super_view.bounds.width - (2.0 * margin), height: super_view.bounds.height - selected_label.frame.maxY));
        
        table.backgroundColor = LIGHT_GRAY;
        table.layer.borderWidth = 1.0;
        super_view.addSubview(table);
        // table appearance
        table.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        // SET DATA SOURCE AND DELEGATE
        table.dataSource = self;
        table.delegate = self;
        
        
    }
    
    func delete_palet(sender:DeleteButton)
    {
        let name = palette_names[sender.tag];
        delete_group(name);
        remove_palet(name);
        
        palette_names.removeAtIndex(sender.tag);
        print("Palet count: " + String(palette_names.count));
        print(sender.tag);

        for(var i = 0; i < palette_names.count; ++i)
        {
            print(palette_names[i]);
        }
        
        table.reloadData();
        nav_controller.copy_controller.table.reloadData();
        nav_controller.new_palet_controller.table.reloadData();
    }
    
    
    override func push_left(duration: NSTimeInterval) {
        super.push_left(duration);
        selected_index = -1;
        //table.reloadData();
        
    }
    
    override func push_right(duration: NSTimeInterval) {
        super.push_right(duration);
        selected_index = -1;
        //table.reloadData();
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}