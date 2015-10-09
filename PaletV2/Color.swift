//
//  Color.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

let DARK_GRAY = UIColor(red: 66.0 / 255.0, green: 66.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0);
let WOLF_GRAY = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0);
let LIGHT_GRAY = UIColor(red: 203.0 / 255.0, green: 203.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0);
let SOFT_RED = UIColor(red: 188.0 / 255.0, green: 44.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0);


let SOFT_GREEN = UIColor(red: 141.0 / 255.0, green: 198.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0); //168,192,120

let SOFT_ORANGE = UIColor(red: 242.0 / 255.0, green: 101.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0); //168,192,120
let MAGENTA = UIColor(red: 218.0 / 255.0, green: 28.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0); //168,192,120
let LIGHT_BLUE = UIColor(red: 39.0 / 255.0, green: 170.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0); //168,192,120


// returns a solid rectangular image of specified color
// to be used for slider class
func get_color_image(color:UIColor, height:CGFloat, width:CGFloat)->UIImage
{
    let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height));
    view.backgroundColor = color;
    return getImageFromView(view);
    
}

func get_rgb(color:UIColor)->String
{
    // update rgb
    
    var red:CGFloat = 0.0;
    var green:CGFloat = 0.0;
    var blue:CGFloat = 0.0;
    var alpha:CGFloat = 0.0;
    
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
    
    let r:Int = Int(255.0 * red);
    let g:Int = Int(255.0 * green);
    let b:Int = Int(255.0 * blue);
    return "(" + String(r) + ", " + String(g) + ", " + String(b) + ")";
}

func get_hex(color:UIColor)->String
{
    // update rgb
    
    var red:CGFloat = 0.0;
    var green:CGFloat = 0.0;
    var blue:CGFloat = 0.0;
    var alpha:CGFloat = 0.0;
    
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
    
    let r:Int = Int(255.0 * red);
    let g:Int = Int(255.0 * green);
    let b:Int = Int(255.0 * blue);
    return NSString(format:"#%02X%02X%02X", r, g, b) as String;
}

func is_valid(hex_code:String)->Bool
{
    if(hex_code.characters.count != 7)
    {
        return false;
    }
    
    // check substrings of length 2 for valid number
    let substr1 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(1), end: hex_code.endIndex.advancedBy(-4)));
    let substr2 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(3), end: hex_code.endIndex.advancedBy(-2)));
    let substr3 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(5), end: hex_code.endIndex));

    let r = UInt8(strtoul(substr1, nil, 16));
    let g = UInt8(strtoul(substr2, nil, 16));
    let b = UInt8(strtoul(substr1, nil, 16));
    
    if((r <= 255) && (g <= 255) && (b <= 255))
    {
        return true;
    }
    return false;
}

func get_color(hex_code:String)->UIColor
{
    // check substrings of length 2 for valid number
    let substr1 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(1), end: hex_code.endIndex.advancedBy(-4)));
    let substr2 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(3), end: hex_code.endIndex.advancedBy(-2)));
    let substr3 = hex_code.substringWithRange(Range<String.Index>(start: hex_code.startIndex.advancedBy(5), end: hex_code.endIndex));
    
    let r = UInt8(strtoul(substr1, nil, 16));
    let g = UInt8(strtoul(substr2, nil, 16));
    let b = UInt8(strtoul(substr1, nil, 16));
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b)  / 255.0, alpha: 1.0);
}