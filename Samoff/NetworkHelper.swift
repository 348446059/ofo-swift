//
//  NetworkHelper.swift
//  Samoff
//
//  Created by libo on 2017/9/19.
//  Copyright © 2017年 libo. All rights reserved.
//
import AVOSCloud

struct NetworkHelper {
    
}

extension NetworkHelper{
   static func getPass(code:String,complete:@escaping(String?)->Void)  {
    let query = AVQuery(className: "Code")
    
    query.whereKey("code", equalTo: code)
    
    query.getFirstObjectInBackground { (code, e) in
        if let e = e {
            print("出错", e.localizedDescription)
            complete(nil)
        }
        
        if let code = code,let pass = code["pass"] as? String{
            complete(pass)
        }
    }
    
    }
}
