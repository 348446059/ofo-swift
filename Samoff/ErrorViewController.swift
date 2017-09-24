//
//  ErrorViewController.swift
//  Samoff
//
//  Created by libo on 2017/9/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import MIBlurPopup
class ErrorViewController: UIViewController{

    @IBOutlet weak var myPopupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTap(_ sender:Any){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gestureTap(_ sender:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ErrorViewController:MIBlurPopupDelegate{
    var popupView: UIView {
        return myPopupView
    }
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    var initialScaleAmmount: CGFloat{
        return 0.2
    }
    var animationDuration: TimeInterval{
        return 0.2
    }
}
