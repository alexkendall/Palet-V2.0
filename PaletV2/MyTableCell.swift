//
//  myTableView.swift
//  Color_Generator
//
//  Created by Alex Harrison on 5/10/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//------------------------------------------------------------------------------------------------
// BEGIN PALETTE TABLE VIEW CELL
//------------------------------------------------------------------------------------------------

/*
class paletteTableViewCell:UITableViewCell
{
    var originalCenter = CGPoint();
    var deleteOnDragRelease = false;
    var delete_button = UIButton();
    var row:Int = Int();
    
    func delete_cell()
    {
        var name = getPaletteName(row);
        var pred = NSPredicate(format:"palette_name like[cd] %@", name);
        var palette_colors = fetch("Color", pred, true);    // get all colors belonging to this palette
        var palette = saved_palettes[row];  // get palette
        
        var app_delgate = UIApplication.sharedApplication().delegate as! AppDelegate;
        var managedContext = app_delgate.managedObjectContext!;
        for(var i = 0; i < palette_colors.count; ++i)   // delete all colors belonging to palette
        {
            managedContext.deleteObject(palette_colors[i]);
        }
        managedContext.deleteObject(palette);   // delete palatte
        saved_palettes.removeAtIndex(row);
        
        var error:NSError?;
        if !managedContext.save(&error)
        {
            println("Unable to delete favorite color");
        }
        
        pallettes_controller.add_controler.palette_table.reloadData();  // reload palette data
        picker_controller.pallete_window.palette_table.reloadData();
    }
    
    //------------------------------------------------------------------------------------------------
    
    func add_delete()
    {
        var but_width = self.frame.size.height; // button width == button height == cell height
        var left_margin = self.frame.size.width - but_width;
        delete_button.backgroundColor = UIColor.redColor();
        delete_button.setTitle("DEL", forState: UIControlState.Normal);
        delete_button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        delete_button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted);
        add_subview(delete_button, self, 0.0, 0.0, left_margin, 0.0);
        delete_button.addTarget(self, action: "delete_cell", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    //------------------------------------------------------------------------------------------------
    
    func remove_delete()
    {
        delete_button.removeFromSuperview();
    }
    
    //------------------------------------------------------------------------------------------------
    
    func pan_recognizer(recognizer:UIPanGestureRecognizer!)
    {
        if(recognizer.state == UIGestureRecognizerState.Began)
        {
            originalCenter = center;
        }
        
        if(recognizer.state == UIGestureRecognizerState.Changed)
        {
            let translation = recognizer.translationInView(self);
            
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y);
            if(frame.origin.x < -frame.size.width / 4.0)
            {
                add_delete();
            }
            if(frame.origin.x > 50.0)
            {
                remove_delete();
            }
        }
        
        if(recognizer.state == UIGestureRecognizerState.Ended)
        {
            let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height);
            UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
        }
    }
    
    //------------------------------------------------------------------------------------------------
    
    // override this in order to enable vertical scrolling of view table
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer
        {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y)
            {
                return true;
            }
            return false;
        }
        return false;
    }
    
    //------------------------------------------------------------------------------------------------
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // add pan recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action: "pan_recognizer:");
        recognizer.delegate = self;
        addGestureRecognizer(recognizer);
    }
    
    //------------------------------------------------------------------------------------------------
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("NSCoding not supported");
    }
    
    //------------------------------------------------------------------------------------------------
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    //------------------------------------------------------------------------------------------------
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated);
    }
    
    //------------------------------------------------------------------------------------------------
    
}
*/

//------------------------------------------------------------------------------------------------
// END PALETTE TABLE VIEW CELL
//------------------------------------------------------------------------------------------------
