//
//  SaveImage.swift
//  HeatGrid
//
//  Created by Alex Harrison on 8/19/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

// function that converts uview to a uimage
func getImageFromView(view:UIView)->UIImage
{
    let rect:CGRect = view.bounds;
    UIGraphicsBeginImageContext(rect.size);
    let context:CGContextRef = UIGraphicsGetCurrentContext()!;
    view.layer.renderInContext(context);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

