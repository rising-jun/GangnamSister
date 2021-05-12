//
//  BannerCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/24.
//

import Foundation
import UIKit
class BannerCollection: NSObject {
    private var bannerInfoArr: [BannerInfo] = []
    public var bannerInfoArr_: [BannerInfo]{
        set(val){
            bannerInfoArr = val
        }get{
            return bannerInfoArr
        }
    }
    
}
extension BannerCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerInfoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.imageView.image = bannerInfoArr[indexPath.row].image_
        cell.infoLabel.text = bannerInfoArr[indexPath.row].nameLoc_
        cell.titleLabel.text = bannerInfoArr[indexPath.row].title_
        cell.subTitleLabel.text = bannerInfoArr[indexPath.row].subTitle_
        cell.scoreLabel.text = bannerInfoArr[indexPath.row].score_
        cell.priceLabel.text = bannerInfoArr[indexPath.row].price_
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(320), height: CGFloat(90))
    }
    
}
