//
//  File.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/08.
//

import Foundation
import UIKit

struct BeforeAfterInfo{
    
    private var seq: Int!
    var seq_: Int{
        set(val){
            seq = val
        }
        get{
            return seq
        }
    }
    
    private var titleImage: UIImage!
    var titleImage_: UIImage{
        set(val){
            titleImage = val
        }
        get{
            return titleImage
        }
    }
    
    private var beforeImage: UIImage!
    var beforeImage_: UIImage{
        set(val){
            beforeImage = val
        }
        get{
            return beforeImage
        }
    }
    
    private var afterImage: UIImage!
    var afterImage_: UIImage{
        set(val){
            afterImage = val
        }
        get{
            return afterImage
        }
    }
    
    private var tagString: [String]!
    var tagString_: [String]{
        set(val){
            tagString = val
        }
        get{
            return tagString
        }
    }
    
    public static func setInfoAuto(seq: Int) -> BeforeAfterInfo{
        var info = BeforeAfterInfo()
        info.seq_ = seq
        if seq == 0 {
            info.titleImage_ = UIImage(named: "mac1")!
            info.beforeImage_ = UIImage(named: "mac2")!
            info.afterImage_ = UIImage(named: "mac1")!
            info.tagString_ = ["눈매교정", "코"]
        }else{
            info.titleImage_ = UIImage(named: "mac3")!
            info.beforeImage_ = UIImage(named: "mac4")!
            info.afterImage_ = UIImage(named: "mac3")!
            info.tagString_ = ["쌍커풀", "교정"]
        }
        
        return info
    }
}
