//
//  ReviewCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/25.
//

import Foundation
import UIKit
import SnapKit
import RxGesture

class ReviewCell: UICollectionViewCell{
    lazy var view = UIView()
    lazy var iconlayerView = UIView()
    lazy var iconView = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var levelLabel = UILabel()
    lazy var selectedView = UIView()
    
    var imageCollection: UICollectionView!
    var tagCollection: UICollectionView!
    
    private var reviewData = ReviewImageCollection()
    public var reviewData_: ReviewImageCollection{
        get{
            return reviewData
        }set(val){
            reviewData = val
        }
    }
    
    private var tagData = TagCollection()
    public var tagData_: TagCollection{
        get{
            return tagData
        }set(val){
            tagData = val
        }
    }
    
    lazy var reviewLabel = UILabel()
    
    lazy var heartIcon = UIImageView()
    lazy var heartLabel = UILabel()
    
    lazy var talkIcon = UIImageView()
    lazy var talkLabel = UILabel()
    
    lazy var line = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(contentView)
        }
        
        let imageLayout = UICollectionViewFlowLayout()
        imageLayout.scrollDirection = .horizontal
        imageCollection = UICollectionView(frame: .zero, collectionViewLayout: imageLayout)
        
        let tagLayout = UICollectionViewFlowLayout()
        tagLayout.scrollDirection = .horizontal
        tagCollection = UICollectionView(frame: .zero, collectionViewLayout: tagLayout)
        
        view.addSubViews(iconlayerView, nameLabel, levelLabel, imageCollection, tagCollection, reviewLabel, heartIcon, heartLabel, talkIcon, talkLabel, selectedView, line)
        iconlayerView.backgroundColor = .lightGray
        iconView.contentMode = .scaleAspectFit
        iconlayerView.layer.cornerRadius = 17
        
        iconlayerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(30)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(34)
            
        }
        
        iconlayerView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(iconlayerView).offset(5)
            make.bottom.trailing.equalTo(iconlayerView).offset(-5)
            
        }
        
        nameLabel.text = "name"
        nameLabel.textSizeAlignSet()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.leading.equalTo(iconView.snp.trailing).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        
        levelLabel.text = "level"
        levelLabel.textSizeAlignSet()
        levelLabel.textColor = .brown
        levelLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
        imageCollection.dataSource = reviewData
        imageCollection.delegate = reviewData
        imageCollection.backgroundColor = .white
        imageCollection.isScrollEnabled = true
        imageCollection.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.equalTo(375)
            make.height.equalTo(130)
        }
        
        tagCollection.dataSource = tagData
        tagCollection.delegate = tagData
        tagCollection.backgroundColor = .white
        tagCollection.snp.makeConstraints { (make) in
            make.top.equalTo(imageCollection.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.equalTo(imageCollection.snp.width)
            make.height.equalTo(20)
        }
        
        reviewLabel.textAlignment = .left
        reviewLabel.textColor = .black
        reviewLabel.font = reviewLabel.font.withSize(15)
        reviewLabel.adjustsFontSizeToFitWidth = false
        reviewLabel.numberOfLines = 3
        reviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tagCollection.snp.bottom).offset(10)
            make.width.equalTo(view)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(60)
        }
        
        heartIcon.image = UIImage(named: "healingPaper")
        heartIcon.contentMode = .scaleAspectFit
        heartIcon.snp.makeConstraints { (make) in
            make.top.equalTo(reviewLabel.snp.bottom).offset(10)
            make.height.width.equalTo(15)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        heartLabel.textSizeAlignSet()
        heartLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(heartIcon)
            make.leading.equalTo(heartIcon.snp.trailing).offset(5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        talkIcon.image = UIImage(named: "talk")
        talkIcon.contentMode = .scaleAspectFit
        talkIcon.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.leading.equalTo(heartLabel.snp.trailing).offset(15)
            make.centerY.equalTo(heartIcon)
        }
        
        talkLabel.textSizeAlignSet()
        talkLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(talkIcon)
            make.leading.equalTo(talkIcon.snp.trailing).offset(5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        selectedView.backgroundColor = .white
        selectedView.snp.makeConstraints { (make) in
            make.centerY.equalTo(talkIcon)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.height.equalTo(15)
        }
        
        line.backgroundColor = .lightGray
        line.snp.makeConstraints { (make) in
            make.top.equalTo(heartIcon.snp.bottom).offset(20)
            make.width.equalTo(self)
            make.height.equalTo(0.5)
        }
        
    }
    
}

