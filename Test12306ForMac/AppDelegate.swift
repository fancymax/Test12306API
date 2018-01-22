//
//  AppDelegate.swift
//  Test12306ForMac
//
//  Created by fancymax on 2018/1/22.
//  Copyright © 2018年 fancyApp. All rights reserved.
//

import Cocoa
import WebAPI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var webAPI:WebAPI!

    @IBAction func clickTest(_ sender: Any) {
        webAPI.queryTicketFlow()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        webAPI =  WebAPI()
    }


}

