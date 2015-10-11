//
//  AppDelegate.swift
//  Mine_Escape
//
//  Created by Alex Harrison on 5/18/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import UIKit
import CoreData
import iAd

enum DEVICE_TYPE{case IPHONE_4, IPHONE_5, IPHONE_6, IPHONE_6_PLUS, IPAD, IWATCH};
var DEVICE_VERSION:DEVICE_TYPE = DEVICE_TYPE.IPHONE_6; // default device
var DEVICE_HEIGHT = CGFloat();
var DEVICE_WIDTH = CGFloat();

var banner_view = ADBannerView();

func setDeviceInfo()
{
    DEVICE_HEIGHT = nav_controller.view.bounds.height;
    DEVICE_WIDTH = nav_controller.view.bounds.width;
    
    if(DEVICE_HEIGHT == 480)
    {
        DEVICE_VERSION = DEVICE_TYPE.IPHONE_4;
        print("iphone4");
    }
    else if(DEVICE_HEIGHT == 568)
    {
        DEVICE_VERSION = DEVICE_TYPE.IPHONE_5;
        print("iphone5");
    }
    else if(DEVICE_HEIGHT == 667)
    {
        DEVICE_VERSION = DEVICE_TYPE.IPHONE_6;
        print("iphone6");
    }
    else if(DEVICE_HEIGHT == 736)
    {
        DEVICE_VERSION = DEVICE_TYPE.IPHONE_6_PLUS;
        print("iphone6 plus");
    }
    else if(DEVICE_HEIGHT > 736)
    {
        DEVICE_VERSION = DEVICE_TYPE.IPAD;
        print("ipad");
    }
}



