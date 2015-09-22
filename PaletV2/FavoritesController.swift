//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class FavoritesController:AuxillaryController, UITableViewDataSource, UITableViewDelegate
{
    var margin:CGFloat!;
    var table:UITableView!;
    var label_texts = ["NEW PALETTE", "VIEW PALETTES", "VIEW FAVORITES", "COLOR PICKER", "EMAIL PALETTE"];
    var colors = [UIColor]();
    var selected_index:Int = -1;
    var selected_colors = Set<Int>();
    var sorted_colors = [Int]();
    
    
    
    func load_favorites()
    {
        colors.removeAll(keepCapacity: true);
        let fav_colors = fetch_colors(FAVORITE_GROUP_NAME);
        for(var i = 0; i < fav_colors!.count; ++i)
        {
            colors.append(get_color(fav_colors![i]));
        }
    }
    
    // START UITABLEVIEWDATASOURCE PROTOCOL IMPLEMENTATION------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell();
        let color = colors[indexPath.row];
        let color_margin:CGFloat = cell.frame.height * 0.1;
        let sub_dim:CGFloat = cell.frame.height - (2.0 * color_margin);
        
        // configure color view to show favorited color
        let color_view = UIView(frame: CGRect(x: color_margin, y: color_margin, width: sub_dim, height: sub_dim));
        color_view.layer.borderWidth = 1.0;
        color_view.layer.borderColor = UIColor.whiteColor().CGColor;
        color_view.backgroundColor = color;
        cell.addSubview(color_view);
        
        // configure color label to display color information
        let padding = "  ";
        let rgb_text = get_rgb(color);
        let hex_text = get_hex(color);
        let text = padding + hex_text + padding + rgb_text;
        let label_width:CGFloat = cell.frame.width - color_view.frame.maxX;
        let rgb_label = UILabel(frame: CGRect(x: color_view.frame.maxX, y: 0.0, width: label_width, height: cell.frame.height));
        rgb_label.text = text;
        rgb_label.font = UIFont.systemFontOfSize(14.0);
        rgb_label.textColor = UIColor.whiteColor();
        cell.addSubview(rgb_label);
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        // configure chech button that allows users to delete and copy colors
        let button_dim:CGFloat = cell.bounds.height * 0.7;
        let button_margin:CGFloat = (cell.bounds.height - button_dim) * 0.5;
        let button_x:CGFloat = cell.bounds.width - button_dim - button_margin;

        let check_button = CheckButton(x: button_x, y: button_margin, in_highlight_color: UIColor.whiteColor(), in_unhigh_color: SOFT_GREEN, dim: button_dim);
        check_button.tag = indexPath.row;
        check_button.addTarget(self, action: "clicked:", forControlEvents: UIControlEvents.TouchUpInside);
        check_button.set_border_color(UIColor.whiteColor());
        check_button.set_path_width(2.0);
        check_button.set_border_width(2.0);
        check_button.set_highlight_color(UIColor.clearColor());
        check_button.set_unhighlight_color(UIColor.clearColor());
        check_button.set_image_color(UIColor.whiteColor());
        
        cell.addSubview(check_button);
        
        
    
        // alternate colors
        if((indexPath.row % 2) == 1)
        {
            cell.backgroundColor = DARK_GRAY;
        }
        else
        {
            cell.backgroundColor = WOLF_GRAY;
        }
        
        return cell;
    }
    
    func clicked(sender:CheckButton)
    {
        if(!sender.active_flag)
        {
            selected_colors.insert(sender.tag);
            sorted_colors = selected_colors.sort(>);
            nav_controller.operation_controller.show("")
        }
        else
        {
            selected_colors.remove(sender.tag);
            if(selected_colors.count == 0)
            {
                nav_controller.operation_controller.hide();
                nav_controller.copy_controller.hide();
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        load_favorites();
        return colors.count;
    }
    
    func delete_colors()
    {
        for(var i = 0; i < sorted_colors.count; ++i)
        {
            let index = sorted_colors[i];
            delete_color(colors[index], group: FAVORITE_GROUP_NAME)
            colors.removeAtIndex(index);
        }
        sorted_colors.removeAll();
        selected_colors.removeAll();
        table.reloadData();
        nav_controller.operation_controller.hide();
    }
    
    
    // END UITABLEVIEWDATASOURCE PROTOCOL IMPLEMENTATION--------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.selected_index = indexPath.row;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super_view.frame = left_frame;
        margin = 15.0;
        
        // configure back view
        let table_frame = CGRect(x: margin, y: margin, width: super_view.frame.width - (2.0 * margin), height: super_view.bounds.height - (2.0 * margin));
        table = UITableView(frame: table_frame, style: UITableViewStyle.Plain);
        table.backgroundColor = DARK_GRAY;
        super_view.addSubview(table);
        table.dataSource = self;
        table.delegate = self;
        table.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    // this override removes any table cell highlights when view is pushed out
    override func push_left(duration: NSTimeInterval) {
        super.push_right(duration);
        selected_index = -1;
        table.reloadData();
        nav_controller.operation_controller.hide();
        selected_colors.removeAll();
    }
    
    // this override removes any table cell highlights when view is pushed out
    override func push_right(duration: NSTimeInterval) {
        super.push_right(duration);
        selected_index = -1;
        table.reloadData();
        nav_controller.operation_controller.hide();
        selected_colors.removeAll();
    }
}