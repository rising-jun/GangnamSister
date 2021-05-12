//
//  TagCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/21.
//

import Foundation
import UIKit
class TagCollection: NSObject {
    private var tagArr: [String] = []
    public var tagArr_: [String]{
        set(val){
            tagArr = val
        }get{
            return tagArr
        }
    }
    
}
extension TagCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tagArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagCell
        cell.grayView.snp.updateConstraints { (make) in
            make.width.equalTo(tagArr[indexPath.row].count * 15 + 22)
        }
        
        cell.tagLabel.snp.updateConstraints { (make) in
            make.width.equalTo(tagArr[indexPath.row].count * 15)
        }
        cell.tagLabel.text = tagArr[indexPath.row]
        
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(tagArr[indexPath.row].count * 15 + 22), height: CGFloat(20))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
    
    
}
