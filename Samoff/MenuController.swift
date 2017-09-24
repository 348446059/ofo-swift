//
//  MenuController.swift
//  Samoff
//
//  Created by libo on 2017/9/10.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import SWRevealViewController

class MenuController: UITableViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.balanceLabel.text = "120.9"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

}
