//
//  UserInfo.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/17.
//

import Foundation
struct UserInfo{
    private var userId: String = ""
    var userId_: String{
        set(val){
            userId = val
        }
        get{
            return userId
        }
    }
    private var password: String = ""
    var password_: String{
        set(val){
            password = val
        }
        get{
            return password
        }
    }
    
}
