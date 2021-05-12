//
//  BannerPagerCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/24.
//

import Foundation
import UIKit

class BannerPagerCell: UICollectionViewCell{
    private var collectionView: UICollectionView!
    private var bannerFacData = BannerCollection()
    private var bannerInfoArr: [BannerInfo] = []
    public var bannerInfoArr_: [BannerInfo]{
        set(val){
            bannerInfoArr = val
        }get{
            return bannerInfoArr
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bannerPagerLayout = UICollectionViewFlowLayout()
        bannerPagerLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: bannerPagerLayout)
        
        contentView.addSubview(collectionView)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.dataSource = bannerFacData
        collectionView.delegate = bannerFacData
        bannerFacData.bannerInfoArr_ = bannerInfoArr
        collectionView.reloadData()
        
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(500)
        }
        
    }
}
