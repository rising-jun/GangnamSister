//
//  BannerPagerCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/24.
//

import Foundation
import UIKit

class BannerPagerCollection: NSObject {
    var currentIdx: CGFloat = 0.0
    
    private var bannerInfoArr: [BannerInfo] = []
    public var bannerInfoArr_: [BannerInfo]{
        set(val){
            bannerInfoArr = val
        }get{
            return bannerInfoArr
        }
    }
    
    private var count = 0
    
}
extension BannerPagerCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(bannerInfoArr.count % 3 != 0){
            return bannerInfoArr.count/3 + 1
        }else{
            return bannerInfoArr.count/3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerPagerCell", for: indexPath) as! BannerPagerCell
        var partDataArr: [BannerInfo] = []
        for i in 0..<3{
            if indexPath.row * 3 + i < bannerInfoArr.count{
                partDataArr.append(bannerInfoArr[indexPath.row * 3 + i])
            }
        }
        
        
        cell.bannerInfoArr_ = partDataArr
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(340), height: CGFloat(300))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let cv = scrollView as? UICollectionView {
            
            let layout = cv.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let idx = round((offset.x + cv.contentInset.left) / cellWidth)
            
            if idx > currentIdx {
                currentIdx += 1
            } else if idx < currentIdx {
                if currentIdx != 0 {
                    currentIdx -= 1
                }
            }
            
            offset = CGPoint(x: currentIdx * cellWidth - cv.contentInset.left, y: 0)
            
            targetContentOffset.pointee = offset
            
        }
        
        
    }
    
}
