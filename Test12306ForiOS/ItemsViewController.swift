//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by fancymax on 26/08/2017.
//  Copyright © 2017 ws. All rights reserved.
//

import UIKit
import WebAPI

class ItemsViewController: UITableViewController {
    
    var webAPI:WebAPI!
    var tickets: [QueryLeftNewDTO]?
    
    @IBAction func clickQueryTicket(_ sender: Any) {

        var params = LeftTicketParam()
        params.train_date = convertDates2Str(Date())
        
        let successHandler = { (tickets:[QueryLeftNewDTO])->()  in
            self.tickets = tickets
            self.tableView.reloadData()
        }
        
        let failureHandler = {(error:NSError)->() in
            
        }
        
        webAPI.queryTicketFlowWith(params, success: successHandler, failure: failureHandler)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webAPI =  WebAPI()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    func convertDates2Str(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tickets == nil {
            return 0
        }
        return self.tickets!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        let item = self.tickets![indexPath.row]
        cell?.textLabel?.text = item.station_train_code
        cell?.detailTextLabel?.text = item.ze_num
        
        return cell!
    }
}
