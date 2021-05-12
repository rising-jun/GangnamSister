//
//  ReviewCollectionData.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ReviewCollectionData: NSObject{
    private var reviewInfoArr: [ReviewInfo] = []
    public var reviewInfoArr_: [ReviewInfo]{
        get{
            return reviewInfoArr
        }set(val){
            reviewInfoArr = val
        }
    }
    
    private var selectedReview: PublishSubject<[Bool]>!
    public var selectedReview_: PublishSubject<[Bool]>{
        get{
            return selectedReview
        }set(val){
            selectedReview = val
        }
    }
    
    private var selectedArr: [Bool] = []
    private var arrCounter: Int = 0
    
    private var reviewData: ReviewImageCollection!
    private var tagData = TagCollection()
    
    private var compareMode = false
    public var compareMode_: Bool{
        get{
            return compareMode
        }set(val){
            compareMode = val
        }
    }
    
}
extension ReviewCollectionData: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for i in 0 ..< reviewInfoArr_.count{
            selectedArr.append(false)
        }
        return reviewInfoArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        reviewData = ReviewImageCollection()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        cell.awakeFromNib()
        let reviewInfo = reviewInfoArr[indexPath.row]
        
        cell.imageCollection.register(ReviewImageCell.self, forCellWithReuseIdentifier: "reviewImageCell")
        cell.reviewData_.imageArr_ = reviewInfo.imageArr_
        
        cell.tagCollection.register(TagCell.self, forCellWithReuseIdentifier: "tagCell")
        cell.tagData_.tagArr_ = reviewInfo.tagArr_
        
        cell.nameLabel.text = reviewInfo.name_
        cell.levelLabel.text = "level \(reviewInfo.level_!)"
        cell.iconView.image = reviewInfo.icon_
        cell.heartLabel.text = reviewInfo.heart_
        cell.talkLabel.text = reviewInfo.talk_
        cell.reviewLabel.text = reviewInfo.descipsion_ 
        cell.reviewLabel.textAlignment = .left
        cell.nameLabel.snp.updateConstraints { (make) in
            make.width.equalTo(reviewInfo.name_.count * 15)
        }
        if(compareMode){
            if selectedArr[indexPath.row]{
                cell.selectedView.backgroundColor = .black
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 360)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if compareMode{
            let cell = collectionView.cellForItem(at: indexPath) as! ReviewCell
            if selectedArr[indexPath.row] == true {
                
                arrCounter -= 1
                selectedArr[indexPath.row] = false
                cell.selectedView.backgroundColor = .white
                
            }else{
                if arrCounter < 2{
                arrCounter += 1
                selectedArr[indexPath.row] = true
                    cell.selectedView.backgroundColor = .black
                }
            }
            selectedReview.onNext(selectedArr)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
