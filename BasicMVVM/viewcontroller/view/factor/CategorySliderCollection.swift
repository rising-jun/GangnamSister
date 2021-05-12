//
//  CategorySliderCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/04.
//

import Foundation
import UIKit
import RxSwift

class CategorySliderCollection: NSObject {
    
    private let disposeBag = DisposeBag()
    private var categoryTag: PublishSubject<String>!
    public var categoryTag_: PublishSubject<String>{
        get{
            return categoryTag
        }set(val){
            categoryTag = val
        }
    }
    
    private var categoryArr: [CategoryInfo] = []
    public var categoryArr_: [CategoryInfo]{
        set(val){
            categoryArr = val
        }get{
            return categoryArr
        }
    }
    
}
extension CategorySliderCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorySliderCell", for: indexPath) as! CategorySliderCell
        cell.setCellData(icon: categoryArr[indexPath.row].icon_, category: categoryArr[indexPath.row].category_)
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(65), height: CGFloat(80))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategorySliderCell
        let category = cell.categoryLabel.text
        categoryTag.on(.next(category ?? "전체"))
        
    }
    
    
}
