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
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true);
    fetchRequest.sortDescriptors = [sortDescriptor];
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
func store_color(color:UIColor, group:String)
{
    var red:CGFloat = 0;
    var green:CGFloat = 0;
    var blue:CGFloat = 0;
    var alpha:CGFloat = 0;
    let date = NSDate();
    
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
    color_data.setValue(date, forKey: "date");
    //4

    save_context();
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
    save_context();
    
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        for(var i = 0; i < color_objects?.count; ++i)
        {
            let color_data = color_objects![i] as NSManagedObject;
            managedContext?.deleteObject(color_data);
        }
        save_context();
    }
    
}

// returns color from managed object
func get_color(color_data:NSManagedObject)->UIColor
{
    let red = color_data.valueForKey("red") as! CGFloat;
    let green = color_data.valueForKey("green") as! CGFloat;
    let blue = color_data.valueForKey("blue") as! CGFloat;
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0);
}



// fetehces all palets
func fetch_palets()->[NSManagedObject]?
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext;
    let fetchRequest = NSFetchRequest(entityName: "Palet");
    let sort_descriptor = NSSortDescriptor(key: "palet_name", ascending: true);  // sort alphabetically
    fetchRequest.sortDescriptors = [sort_descriptor];
    do {
        let fetchedResults = try managedContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        print("PALETS STORED COUNT: " + String(fetchedResults?.count));
        return fetchedResults!;
    } catch let fetchError as NSError {
        print("fetch error: \(fetchError.localizedDescription)")
        return nil;
    }
    
}

// fetehces all palets
func fetch_palet(name:String)->[NSManagedObject]?
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext;
    let fetchRequest = NSFetchRequest(entityName: "Palet");
    let predicate = NSPredicate(format:"palet_name like[cd] %@", name);
    fetchRequest.predicate = predicate;
    
    do {
        let fetchedResults = try managedContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        print("PALETS STORED COUNT: " + String(fetchedResults?.count));
        return fetchedResults!;
    } catch let fetchError as NSError {
        print("fetch error: \(fetchError.localizedDescription)")
        return nil;
    }
}

func get_palet(palet_data:NSManagedObject)->String
{
    return palet_data.valueForKey("palet_name") as! String;
}

// stores color in group
func store_palet(name:String)
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext!;
    let entity = NSEntityDescription.entityForName("Palet", inManagedObjectContext: managedContext);
    let palet_data = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext);
    palet_data.setValue(name, forKey: "palet_name");
    // here's the sugar
    save_context();
}


// deletes color from group
func remove_palet(name:String)
{
    let palets:[NSManagedObject]? = fetch_palet(name);
    if(palets == nil)
    {
        print("palets not found");
    }
    else
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        for(var i = 0; i < palets!.count; ++i)
        {
            let palet = palets![i] as NSManagedObject;
            managedContext?.deleteObject(palet);
        }
        save_context();
    }
}

func save_context()
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let managedContext = appDelegate.managedObjectContext;
    do {
        try managedContext!.save()
    } catch let fetchError as NSError {
        print("Unable to save palet: \(fetchError.localizedDescription)")
    }

}

