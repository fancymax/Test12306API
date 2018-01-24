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

    var webAPI:WebAPI!
    var tickets: [QueryLeftNewDTO]?

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var ticketTableView: NSTableView!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    @IBAction func clickQueryTicket(_ sender: Any) {
        var params = LeftTicketParam()
        params.train_date = convertDates2Str(datePicker.dateValue)
        
        let successHandler = { (tickets:[QueryLeftNewDTO])->()  in
            self.tickets = tickets
            self.ticketTableView.reloadData()
        }
        
        let failureHandler = {(error:NSError)->() in
            
        }
        
        webAPI.queryTicketFlowWith(params, success: successHandler, failure: failureHandler)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        webAPI =  WebAPI()
        datePicker.dateValue = Date()
    }
    
    func convertDates2Str(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
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

