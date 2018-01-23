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
    
    @IBAction func clickTest(_ sender: Any) {
        if let webTickets = webAPI.queryTicketFlow() {
            self.tickets = webTickets
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webAPI =  WebAPI()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @IBAction func toggleEditingMode(_ sender:UIButton) {
        
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
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
//        cell?.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let item = itemStore.allItems[indexPath.row]
//            itemStore.removeItem(item)
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}