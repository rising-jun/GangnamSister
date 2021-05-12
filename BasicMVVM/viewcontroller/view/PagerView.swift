//
//  PagerView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/11.
//

import Foundation
import UIKit

class PagerView: BaseView{
    
    private let pageViewFactor = PageViewFactor()
    
    lazy var menuTabBar = UICollectionView()
    var pager: UICollectionView!
    lazy var highlightView = UIView()
    
    override func setup() {
        super.setup()
        let pagerLayout = UICollectionViewFlowLayout()
        pagerLayout.scrollDirection = .horizontal
        
        let menuLayout = UICollectionViewFlowLayout()
        menuLayout.scrollDirection = .horizontal
        pager = UICollectionView(frame: .zero, collectionViewLayout: pagerLayout)
        menuTabBar = UICollectionView(frame: .zero, collectionViewLayout: menuLayout)
        addSubViews(menuTabBar, pager, highlightView)
        
        menuTabBar.bounces = false
        menuTabBar.showsHorizontalScrollIndicator = false
        menuTabBar.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(50)
            make.top.equalTo(self.snp.top)
        }
        
        highlightView.backgroundColor = .black
        highlightView.snp.makeConstraints { (make) in
            make.height.equalTo(3)
            make.top.equalTo(menuTabBar.snp.bottom).offset(0)
        }
        
        pager.bounces = false
        pager.isPagingEnabled = true
        pager.showsHorizontalScrollIndicator = false
        
        pager.snp.makeConstraints { (make) in
            make.top.equalTo(highlightView.snp.bottom).offset(0)
            make.width.equalTo(self)
            make.height.equalTo(self).offset(-138)
        }
    
    }
}
