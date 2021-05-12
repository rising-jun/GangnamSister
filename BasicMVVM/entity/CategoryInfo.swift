//
//  CategoryInfo.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/30.
//

import Foundation
import UIKit

struct CategoryInfo{
    private var icon: UIImage!
    public var icon_: UIImage{
        set(val){
            icon = val
        }
        get{
            return icon
        }
    }
    
    private var category: String!
    public var category_: String{
        set(val){
            category = val
        }
        get{
            return category
        }
    }
    
    private var categoryTags: [String]!
    public var categoryTags_: [String]{
        set(val){
            categoryTags = val
        }
        get{
            return categoryTags
        }
    }
    
}
