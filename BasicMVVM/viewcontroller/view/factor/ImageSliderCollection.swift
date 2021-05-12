//
//  ImageSliderCollection.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ImageSliderCollection: NSObject {
    private var timer : BehaviorRelay = BehaviorRelay(value: true)
    private var disposeBag = DisposeBag()
    private var index: Int = 0
    private var slider: UICollectionView!
    public var slider_: UICollectionView{
        get{
            return slider
        }set(val){
            slider = val
        }
    }
    private var imageArr: [UIImage] = []
    public var imageArr_: [UIImage]{
        get{
            return imageArr
        }set(val){
            imageArr = val
            
        }
    }
    
    public func timerStart(){
        //print(imageArr.count)
        timer.asObservable()
            .flatMapLatest { isRunning in
                isRunning ? Observable<Int>
                    .interval(.seconds(3), scheduler: MainScheduler.instance) : .empty()
            }
            .subscribe(onNext: { [weak self] value in
                //get cell size
                
            self?.moveToNextPage(collectionView: self!.slider,timer: true)
            }).disposed(by: disposeBag)
    }
    
    private func moveToNextPage(collectionView: UICollectionView,timer : Bool){
        
        let cellSize = CGSize(width: collectionView.frame.width, height: 260);
                //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset
                //scroll to next cell
        if timer {
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        }
        let pageFloat = ( collectionView.contentOffset.x /  collectionView.frame.size.width)
        let pageInt = Int(round(pageFloat))

        switch pageInt {
        case 0:
            if !timer{
                    //collectionView.scrollToItem(at: [0, self.imageArr.count], at: .left, animated: false)
                    collectionView.scrollToItem(at: IndexPath(row: 5001, section: 0), at: .left, animated: false)
                    //print("worked")
                
               
            }
        break
        case 1000:
            collectionView.scrollToItem(at: IndexPath(row: 5001, section: 0), at: .right, animated: timer)

        break
        default:
            break
        }
    }

}

extension ImageSliderCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as? ImageSliderCell
        if imageArr.count != 0{
            cell?.setImage(image: imageArr[indexPath.row % imageArr.count])
            
        }
        cell?.awakeFromNib()
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds
        return CGSize(width: size.width, height: size.height)
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        timer.accept(true)
        self.moveToNextPage(collectionView: scrollView as! UICollectionView,timer: false)
    }

    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.accept(false)
    }
}
