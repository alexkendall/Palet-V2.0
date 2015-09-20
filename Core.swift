//
//  Core.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/20/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// fetches specified color from group
func fetch_color(color:UIColor, group:String)->[NSManagedObject]!
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext;
    
    var red:CGFloat = 0;
    var green:CGFloat = 0;
    var blue:CGFloat = 0;
    var alpha:CGFloat = 0;
    
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
    let r = Double(red);
    let g = Double(green);
    let b = Double(blue);
    
    let fetchRequest = NSFetchRequest(entityName: "Color");
    let pred = NSPredicate(format:"(group like[cd] %@) AND (red == %f) AND (green == %f) AND (blue == %f)", group, r, g, b);
    fetchRequest.predicate = pred;
    
    // here's the sugar
    do {
        let fetchedResults = try managedContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject]!
        print("COLOR FOUND: " + String(fetchedResults?.count));
        return fetchedResults!;
    } catch let fetchError as NSError {
        print("fetch error: \(fetchError.localizedDescription)")
        return nil;
    }
}

// fetched every color belonging to specified group
func fetch_colors(group:String)->[NSManagedObject]?
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext;
    let fetchRequest = NSFetchRequest(entityName: "Color");
    let predicate = NSPredicate(format:"group like[cd] %@", group);
    fetchRequest.predicate = predicate;
    
    do {
        let fetchedResults = try managedContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        print("COLORS STORED COUNT: " + String(fetchedResults?.count));
        return fetchedResults!;
    } catch let fetchError as NSError {
        print("fetch error: \(fetchError.localizedDescription)")
        return nil;
    }
    
}

// stores color in group
func store_color(group:String, color:UIColor)
{
    var red:CGFloat = 0;
    var green:CGFloat = 0;
    var blue:CGFloat = 0;
    var alpha:CGFloat = 0;
    
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
    
    // 1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext!;
    
    // 2
    let entity = NSEntityDescription.entityForName("Color", inManagedObjectContext: managedContext);
    let color_data = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext);
    
    // 3
    color_data.setValue(Double(red), forKey: "red");
    color_data.setValue(Double(green), forKey: "green");
    color_data.setValue(Double(blue), forKey: "blue");
    color_data.setValue(group, forKey: "group");
    
    //4
    // here's the sugar
    do {
        try managedContext.save()
    } catch let fetchError as NSError {
        print("Unable to save color: \(fetchError.localizedDescription)")
    }
}

// deletes color from group
func delete_color(color:UIColor, group:String)
{
    let color_objects:[NSManagedObject]? = fetch_color(color, group: group);
    if(color_objects == nil)
    {
        print("Color Not found");
    }
    else
    {
        for(var i = 0; i < color_objects?.count; ++i)
        {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            let managedContext = appDelegate.managedObjectContext;
            let color_data = color_objects![i] as NSManagedObject;
            managedContext?.deleteObject(color_data);
        }
    }
    
}

// deletes group
func delete_group(group:String)
{
    let color_objects:[NSManagedObject]? = fetch_colors(group);
    if(color_objects == nil)
    {
        print("Color Not found");
    }
    else
    {
        for(var i = 0; i < color_objects?.count; ++i)
        {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            let managedContext = appDelegate.managedObjectContext;
            let color_data = color_objects![i] as NSManagedObject;
            managedContext?.deleteObject(color_data);
        }
    }
    
}


