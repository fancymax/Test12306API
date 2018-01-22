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
    
    var tickets: [QueryLeftNewDTO]?

    @IBOutlet weak var ticketTableView: NSTableView!
    
    @IBAction func clickTest(_ sender: Any) {
        if let webTickets = webAPI.queryTicketFlow() {
            self.tickets = webTickets
            ticketTableView.reloadData()
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        webAPI =  WebAPI()
    }
}

extension AppDelegate:NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tickets == nil {
            return 0
        }
        return tickets!.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return tickets![row]
    }
    
}

