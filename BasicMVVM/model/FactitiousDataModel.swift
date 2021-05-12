//
//  FactitiousDataModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/04.
//

import Foundation
import UIKit

struct FactitiousDataModel{
    
    public func categoryArrData() -> [CategoryInfo]{
        var categoryArr: [String] = ["전체", "눈", "코", "안면윤곽/양학", "가슴", "지방흡입", "지방이식", "필러", "보톡스", "피부", "쁘띠", "입", "치아/시력교정", "기타"]
        
        var categoryInfoArr: [CategoryInfo] = []
        for category in categoryArr{
            var info = CategoryInfo()
            info.category_ = category
            info.icon_ = UIImage(named: "healingPaper")!
            categoryInfoArr.append(info)
        }
        return categoryInfoArr
    }
    
}
