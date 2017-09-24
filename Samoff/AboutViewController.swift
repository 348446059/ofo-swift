//
//  AboutViewController.swift
//  Samoff
//
//  Created by libo on 2017/9/10.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import SWRevealViewController
class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    if let revealVC = revealViewController() {
            revealVC.rightViewRevealWidth = 280
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
