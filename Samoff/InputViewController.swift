//
//  InputViewController.swift
//  Samoff
//
//  Created by libo on 2017/9/17.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import APNumberPad

class InputViewController: UIViewController ,APNumberPadDelegate,UITextFieldDelegate{
    var isFlashOn = false
    var isVoiceOn = true
    
    @IBOutlet weak var goAction: UIButton!
    
    @IBAction func flashBtnTap(_ sender: UIButton) {
       isFlashOn = !isFlashOn
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        }else{
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        }

    }
    
    @IBAction func voiceBtnTap(_ sender: Any) {
        isVoiceOn = !isVoiceOn
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        }else{
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
        }
    }
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var voiceBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "车辆解锁"
     inputTextField.layer.borderWidth = 2
     inputTextField.layer.borderColor = UIColor.ofo.cgColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫码用车", style: .plain, target: self, action: #selector(backToScan))
        
        
        let numerPad = APNumberPad(delegate:self)
        numerPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTextField.inputView = numerPad
        inputTextField.delegate = self
        
        goAction.isEnabled = false
        
    }
    @objc func backToScan()  {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBtnTap (_ sender: UIButton){
          checkPass()
    }
  
    //MARK numberPad -- delegate
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder & UITextInput) {
      checkPass()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goAction.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goAction.backgroundColor = UIColor.ofo
            goAction.isEnabled = true
        }else{
            goAction.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goAction.backgroundColor = UIColor.groupTableViewBackground
            goAction.isEnabled = false
        }
        return newLength <= 8
        
    }
    
    var passArr:[String] = []
    func checkPass()  {
        if !(inputTextField.text?.isEmpty)! {
             let code = inputTextField.text!
            NetworkHelper.getPass(code: code, complete: { (pass) in
                
                if let pass = pass{
                    self.passArr = pass.map{
                        return $0.description
                    }
                 self.performSegue(withIdentifier:"ShowPasscode", sender: self)
                }else{
                   self.performSegue(withIdentifier: "showErrorView", sender: self)
                }
             })
           
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPasscode" {
            let destVC = segue.destination as! ShowPassViewController
            
           destVC.passArr = self.passArr
           
            
          
        
            
        }
    }
  

}
