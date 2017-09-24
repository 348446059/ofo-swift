//
//  ShowPassViewController.swift
//  Samoff
//
//  Created by libo on 2017/9/17.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import SwiftyTimer
import SwiftySound



class ShowPassViewController: UIViewController {
    var code = ""
    var passArr:[String] = []
    @IBOutlet weak var label1st:MyPreviewLabel!
    @IBOutlet weak var label2st:MyPreviewLabel!
    @IBOutlet weak var label3st:MyPreviewLabel!
    @IBOutlet weak var label4st:MyPreviewLabel!
    @IBOutlet weak var showCountDownLabel: UILabel!
    var remindSeconds = 120
    var isTorchOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.every(1) { (timer:Timer) in
            self.remindSeconds -= 1
            self.showCountDownLabel.text = self.remindSeconds.description
            if self.remindSeconds == 0{
              timer.invalidate()
            }
        }
        Sound.play(file: "骑行结束_LH.m4a")
        self.label1st.text = passArr[0]
        self.label2st.text = passArr[1]
        self.label3st.text = passArr[2]
        self.label4st.text = passArr[3]
    }

    @IBAction func reportBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func torchBtnTap(_ sender:UIButton!){
        turnTorch()
        
        if isTorchOn {
            sender.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        }else{
            sender.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        }
        isTorchOn = !isTorchOn
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
