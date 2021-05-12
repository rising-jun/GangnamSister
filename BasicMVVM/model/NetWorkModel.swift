//
//  NetWorkModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkerModelable {
    func getHomeSliderImage(url: String) -> Observable<UIImage>
}

class NetWorkModel: NetworkerModelable{
    
    public func getHomeSliderImage(url: String) -> Observable<UIImage>{
        var urlRequest = URLRequest(url: URL(string: url)!)
        return URLSession.shared.rx
            .data(request: urlRequest)
            .map{UIImage(data: $0)!}
        
    }
    
    
}
