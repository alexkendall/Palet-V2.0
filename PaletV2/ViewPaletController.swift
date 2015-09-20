//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class ViewPaletController:AuxillaryController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var color_colection:UICollectionView!;
    var margin:CGFloat!;
    var selected_index:Int = -1;
    let info_label = AnimatedView();
    var rgb_label:UILabel!
    var hex_label:UILabel!
    
    var colors = [SOFT_GREEN, SOFT_ORANGE, LIGHT_BLUE, WOLF_GRAY, SOFT_RED];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        margin = 15.0;
        
        // configure collection view
        let collection_frame = CGRect(x: margin, y: margin, width: super_view.frame.width - (2.0 * margin), height: super_view.bounds.height - (2.0 * margin));
        
        
        let layout = UICollectionViewFlowLayout();
        color_colection = UICollectionView(frame: collection_frame, collectionViewLayout: layout);
        color_colection.backgroundColor = DARK_GRAY;
        color_colection.dataSource = self;
        color_colection.delegate = self;
        color_colection.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cell");
        super_view.addSubview(color_colection);
        
        
        // animatable label
        let info_height:CGFloat = super_view.bounds.height * 0.075;
        info_label.in_frame = CGRect(x: 0.0, y: super_view.bounds.height - info_height, width: super_view.bounds.width, height: info_height);
        
        info_label.out_frame = CGRect(x: 0.0, y: super_view.bounds.height, width: super_view.bounds.width, height: info_height);
        
        info_label.frame = CGRect(x: 0.0, y: super_view.bounds.height, width: super_view.bounds.width, height: info_height);
        super_view.addSubview(info_label);
        
        
        
        
        // info label
        rgb_label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: info_label.frame.width * 0.5, height: info_label.frame.height));
        rgb_label.textColor = UIColor.whiteColor();
        rgb_label.textAlignment = NSTextAlignment.Center;
        
        hex_label = UILabel(frame: CGRect(x: rgb_label.frame.maxX, y: 0.0, width: info_label.frame.width * 0.5, height: info_label.frame.height));
        hex_label.textAlignment = NSTextAlignment.Center;
        hex_label.textColor = UIColor.whiteColor();
        
        info_label.backgroundColor = UIColor.blackColor();
        info_label.addSubview(rgb_label);
        info_label.addSubview(hex_label);
        
        


    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    // data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = color_colection.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell;
        cell.backgroundColor = colors[indexPath.row];
        cell.layer.borderColor = UIColor.whiteColor().CGColor;
        
        if(indexPath.row == self.selected_index)
        {
            cell.layer.borderWidth = 4.0;
        }
        else
        {
            cell.layer.borderWidth = 1.0;
        }
        return cell;
    }
    
    
    // customize appearance
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: super_view.bounds.width * 0.2, height: super_view.bounds.width * 0.2);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let margin:CGFloat = super_view.bounds.width * 0.25 / 4;
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return margin * 2.0;
    }
    
    // delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selected_index = indexPath.row;
        color_colection.reloadData();
        selected_color();
    }
    
    func show_palet()
    {
        super_view.addSubview(nav_controller.view);
    }
    
    func selected_color()
    {
        let color = colors[selected_index];
        // get color label
        var red:CGFloat = 0.0;
        var blue:CGFloat = 0.0;
        var green:CGFloat = 0.0;
        var alpha:CGFloat = 0.0;
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
        
        let r:Int = Int(255.0 * red);
        let g:Int = Int(255.0 * green);
        let b:Int = Int(255.0 * blue);
        
        rgb_label.text = "   rgb(" + String(r) + ", " + String(g) + ", " + String(b) + ")";
        hex_label.text = NSString(format:"   #%02X%02X%02X", r, g, b) as String;
        
        info_label.show(1.0);
    }
    
    // override push functions to remove any existing highlights when controller is removed from window
    override func push_left(duration: NSTimeInterval) {
        super.push_left(duration);
        self.selected_index = -1;
        self.color_colection.reloadData();
        info_label.hide(1.0);
    }
    
    override func push_right(duration: NSTimeInterval) {
        super.push_right(duration);
        self.selected_index = -1;
        self.color_colection.reloadData();
        info_label.hide(0.5);
    }
    
    
}




