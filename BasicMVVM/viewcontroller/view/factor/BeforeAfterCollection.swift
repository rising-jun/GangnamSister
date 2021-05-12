//
//  BeforeAfterCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BeforeAfterCollection: NSObject {
    private var slider: UICollectionView!
    public var slider_: UICollectionView{
        get{
            return slider
        }set(val){
            slider = val
        }
    }
    private var imageArr: [BeforeAfterInfo] = []
    public var imageArr_: [BeforeAfterInfo]{
        get{
            return imageArr
        }set(val){
            imageArr = val
        }
    }
    private var baSelected: PublishSubject<Int>!
    public var baSelected_: PublishSubject<Int>{
        get{
            return baSelected
        }set(val){
            baSelected = val
        }
    }
    
    
}

extension BeforeAfterCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bfSliderCell", for: indexPath) as? BeforeAfterCell
        cell?.setImage(image: imageArr[indexPath.row % imageArr.count].titleImage_)
        cell?.awakeFromNib()
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(70), height: CGFloat(70))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        baSelected.on(.next(indexPath.row))
    }
    
}
