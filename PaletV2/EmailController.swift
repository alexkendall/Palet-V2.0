//
//  PaletController.swift
//  PaletV2
//
//  Created by Alex Harrison on 9/16/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class EmailController:MFMailComposeViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // add attachment if user can send mail
        if(MFMailComposeViewController.canSendMail())
        {
            /*
            var image = get_color_image(UIColor.redColor(), height: 1920, width: 1080);
            var data = UIImageJPEGRepresentation(image, 1.0);
            
            self.addAttachmentData(data!, mimeType: "JPEG", fileName: "test_image");
            self.setSubject("alexharr@umich.edu");

            */
        }
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}