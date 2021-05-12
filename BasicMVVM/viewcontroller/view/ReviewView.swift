//
//  ReviewView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/28.
//

import Foundation
import UIKit
import SnapKit

class ReviewView: BaseView{
    lazy var viewTitleLabel = UILabel()
    lazy var myPageIcon = UIImageView()
    lazy var alarmIcon = UIImageView()
    lazy var pencilIcon = UIImageView()
    
    var categorySlider: UICollectionView!
    
    var reviewCollectionView: UICollectionView!
    
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categorySlider = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        categorySlider.isPrefetchingEnabled = false
        
        let reviewLayout = UICollectionViewFlowLayout()
        reviewLayout.scrollDirection = .vertical
        reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reviewLayout)
        
        addSubViews(categorySlider, reviewCollectionView)
        
        categorySlider.backgroundColor = .white
        categorySlider.showsHorizontalScrollIndicator = false
        categorySlider.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(80)
        }
        
        reviewCollectionView.bounces = false
        reviewCollectionView.dragInteractionEnabled  = false
        reviewCollectionView.backgroundColor = .white
        reviewCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(categorySlider.snp.bottom)
            make.height.equalTo(self).offset(-218)
            make.width.equalTo(self)
        }
        
        
    }
    
    public func setNavigationBarIconView() -> UIBarButtonItem{
        let iconView = UIView()
        
        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(340 * frame.width / 375)
            make.height.equalTo(39 * frame.height / 812)
        }
        
        iconView.addSubViews(viewTitleLabel, alarmIcon, myPageIcon, pencilIcon)
    
        viewTitleLabel.text = "시술후기"
        viewTitleLabel.textSizeAlignSet()
        viewTitleLabel.textAlignment = .left
        viewTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView).offset(2)
            make.bottom.equalTo(iconView).offset(-2)
            make.leading.equalTo(iconView).offset(5)
            make.width.equalTo(150)
        }
        
        pencilIcon.image = UIImage(named: "pencil")
        pencilIcon.contentMode = .scaleToFill
        pencilIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(iconView).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        alarmIcon.image = UIImage(named: "alarmIcon")
        alarmIcon.contentMode = .scaleToFill
        alarmIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(pencilIcon.snp.leading).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        myPageIcon.image = UIImage(named: "mypageIcon")
        myPageIcon.contentMode = .scaleToFill
        myPageIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(alarmIcon.snp.leading).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        return UIBarButtonItem(customView: iconView)
    }
}
