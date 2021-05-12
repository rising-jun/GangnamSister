//
//  BannerInfo.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/28.
//

import Foundation
import UIKit

struct BannerInfo{
    private var image: UIImage!
    var image_: UIImage{
        set(val){
            image = val
        }
        get{
            return image
        }
    }
    
    private var nameLoc: String!
    var nameLoc_: String{
        set(val){
            nameLoc = val
        }
        get{
            return nameLoc
        }
    }
    
    private var title: String!
    var title_: String{
        set(val){
            title = val
        }
        get{
            return title
        }
    }
    
    private var subTitle: String!
    var subTitle_: String{
        set(val){
            subTitle = val
        }
        get{
            return subTitle
        }
    }
    
    private var score: String!
    var score_: String{
        set(val){
            score = val
        }
        get{
            return score
        }
    }
    
    private var price: String!
    var price_: String{
        set(val){
            price = val
        }
        get{
            return price
        }
    }
    
    public static func setInfoAuto() -> [BannerInfo]{
        var bannerInfoArr: [BannerInfo] = []
        for i in 0 ..< 8{
            var info = BannerInfo()
            info.image_ = UIImage(named: "mac2")!
            info.nameLoc_ = "서울 신사역 ' 루호성형외과"
            info.title_ = "인생라인 매몰쌍꺼풀"
            info.subTitle_ = "찾았다 인생 쌍꺼풀라인"
            info.score_ = "9.9"
            info.price_ = "49만원"
            bannerInfoArr.append(info)
        }
        return bannerInfoArr
    }
}
