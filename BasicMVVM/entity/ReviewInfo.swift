//
//  ReviewInfo.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/28.
//

import Foundation
import UIKit

struct ReviewInfo{
    
    private var icon: UIImage!
    public var icon_: UIImage{
        set(val){
            icon = val
        }
        get{
            return icon
        }
    }
    
    private var name: String!
    public var name_: String{
        set(val){
            name = val
        }
        get{
            return name
        }
    }
    
    private var level: String!
    public var level_: String!{
        set(val){
            level = val
        }
        get{
            return level
        }
    }
    
    private var imageArr: [UIImage]!
    public var imageArr_: [UIImage]{
        set(val){
            imageArr = val
        }
        get{
            return imageArr
        }
    }

    private var tagArr: [String]!
    public var tagArr_: [String]{
        set(val){
            tagArr = val
        }
        get{
            return tagArr
        }
    }
    
    private var descipsion: String!
    public var descipsion_: String{
        set(val){
            descipsion = val
        }
        get{
            return descipsion
        }
    }
    
    private var heart: String!
    public var heart_: String{
        set(val){
            heart = val
        }
        get{
            return heart
        }
    }
    
    private var talk: String!
    public var talk_: String{
        set(val){
            talk = val
        }
        get{
            return talk
        }
    }
    
    private var doc: String!
    public var doc_: String{
        set(val){
            doc = val
        }
        get{
            return doc
        }
    }
    
    private var price: String!
    public var price_: String{
        set(val){
            price = val
        }
        get{
            return price
        }
    }
    
    private var loc: String!
    public var loc_: String{
        set(val){
            loc = val
        }
        get{
            return loc
        }
    }
    
    private var priceColor: CompareColor!
    public var priceColor_: CompareColor{
        set(val){
            priceColor = val
        }
        get{
            return priceColor
        }
    }
    
    private var heartColor: CompareColor!
    public var heartColor_: CompareColor{
        set(val){
            heartColor = val
        }
        get{
            return heartColor
        }
    }
    
    public static func setReviewInfo(seq: Int) -> ReviewInfo{
        var info = ReviewInfo()
        if seq % 2 == 0{
            info.descipsion = "후기란 입니다. \n재수술받은지 1년지났습니다! \n언니 들에게도 도움이 될까 해서 글 올려봅니다.\n너"
            info.imageArr = [UIImage(named: "mac1")!,UIImage(named: "mac2")!,UIImage(named: "mac3")!]
            info.heart = "12"
            info.level = "4"
            info.name = "강남언니"
            info.tagArr = ["눈", "코"]
            info.icon = UIImage(named: "mypageIcon")
            info.talk = "3"
            info.doc = "강언 원장"
            info.price = "100"
            info.loc = "서울 / 신사역"
        }else{
            info.descipsion = "후기란 입니다2. \n재수술받은지 1년지났습니다! \n언니들 에게도 도움이 될까 해서 글 올려봅니다."
            info.imageArr = [UIImage(named: "mac4")!,UIImage(named: "mac3")!,UIImage(named: "mac2")!]
            info.heart = "19"
            info.level = "7"
            info.name = "힐페지망생"
            info.tagArr = ["입", "피부", "지방흡입"]
            info.icon = UIImage(named: "mypageIcon")
            info.talk = "5"
            info.doc = "힐페 원장"
            info.price = "90"
            info.loc = "서울 / 강남역"
        }
        
        return info
    }
}
