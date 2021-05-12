//
//  ReviewImageCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/26.
//

import Foundation
import UIKit
import SnapKit
class ReviewImageCollection: NSObject{
    
    private var imageArr: [UIImage]!
    public var imageArr_: [UIImage]{
        get{
            return imageArr
        }set(val){
            imageArr = val
        }
    }
    
}

extension ReviewImageCollection: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.contentSize.width = CGFloat(135 * imageArr.count)
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! ReviewImageCell
        cell.setImage(image: imageArr[indexPath.row])
        cell.awakeFromNib()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
