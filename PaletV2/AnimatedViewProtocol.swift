//
//  AnimatedView.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/17/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

// protocol for providing animated views and buttons
protocol AnimatedViewProtocol
{
    // each animated view must have an in frame or an out frame
    var in_frame:CGRect! {get set};
    var out_frame:CGRect! {get set};
    
    // must provide constructor that sets in and out frames
    //init(in_frame:CGRect, out_frame:CGRect);
    
    // animation that shows view
    func show(var duration:NSTimeInterval)
    
    // animation which hides view
    func hide(var duration:NSTimeInterval)
}