//
//  HomeView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/23.
//

import Foundation
import UIKit
import SnapKit

class HomeView: BaseView{
    lazy var searchTextField = UITextField()
    lazy var myPageIcon = UIImageView()
    lazy var alarmIcon = UIImageView()
    
    lazy var scrollView = UIScrollView()
    
    var imageSlider: UICollectionView!
    lazy var pickView = UIView()
    var slidableImage = BeforeAfterView()
    lazy var beforeLabel = UILabel()
    lazy var afterLabel = UILabel()
    var bACollection: UICollectionView!
    var tagCollection: UICollectionView!
    
    lazy var bannerRankView = UIView()
    lazy var bannerImage = UIImageView()
    lazy var bannerLabel = UILabel()
    lazy var bannerTopic = UILabel()
    lazy var bannerSubTopic = UILabel()
    var bannerCollection: UICollectionView!
    var bannerPagerCollection: UICollectionView!
    
    override func setup() {
        super.setup()
        
        scrollView.setDefalutView()
        scrollView.contentSize.height = 1320
        addSubview(scrollView)
        let imageSlidelayout = UICollectionViewFlowLayout()
        imageSlidelayout.scrollDirection = .horizontal
        imageSlider = UICollectionView(frame: .zero, collectionViewLayout: imageSlidelayout)
        scrollView.addSubViews(imageSlider, pickView, bannerRankView)
        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
            
        }
        
        imageSlider.backgroundColor = .white
        imageSlider.isPagingEnabled = true
        imageSlider.showsHorizontalScrollIndicator = false
        
        imageSlider.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.width.equalTo(snp.width)
            make.height.equalTo(150)
        }
        
        let baLayout = UICollectionViewFlowLayout()
        baLayout.scrollDirection = .horizontal
        bACollection = UICollectionView(frame: .zero, collectionViewLayout: baLayout)
        let uiTitleView = getTitleLabel(title: "힐페님을 위한 강언's PICK")
        let line = pickView.addBottomBorderWithColor()
        
        let tagLayout = UICollectionViewFlowLayout()
        tagLayout.scrollDirection = .horizontal
        tagCollection = UICollectionView(frame: .zero, collectionViewLayout: tagLayout)
        
        pickView.addSubViews(uiTitleView, slidableImage,beforeLabel, afterLabel, bACollection, tagCollection, line)
        pickView.snp.makeConstraints { (make) in
            make.top.equalTo(imageSlider.snp.bottom).offset(10)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(480)
        }
        
        line.snp.makeConstraints { (make) in
            make.width.equalTo(pickView)
            make.height.equalTo(0.5)
            make.bottom.equalTo(pickView.snp.bottom)
        }
        
        uiTitleView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(40)
            make.top.equalTo(pickView).offset(20)
        }
        
        slidableImage.backgroundColor = .black
        slidableImage.layer.cornerRadius = 10
        slidableImage.snp.makeConstraints { (make) in
            make.top.equalTo(uiTitleView.snp.bottom)
            make.height.equalTo(250)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        beforeLabel.text = "before"
        beforeLabel.textSizeAlignSet()
        beforeLabel.textColor = .gray
        beforeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slidableImage.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
        afterLabel.text = "after"
        afterLabel.textSizeAlignSet()
        afterLabel.textColor = .orange
        afterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slidableImage.snp.bottom)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        
        
        bACollection.backgroundColor = .white
        bACollection.snp.makeConstraints { (make) in
            make.top.equalTo(afterLabel.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(70)
        }
    
        tagCollection.backgroundColor = .white
        tagCollection.snp.makeConstraints { (make) in
            make.top.equalTo(bACollection.snp.bottom).offset(10)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(20)
        }
        
        let bannerTitleView = getTitleLabel(title: "강남언니가 추천하는 이벤트")
        
        let bannerPagerLayout = UICollectionViewFlowLayout()
        bannerPagerLayout.scrollDirection = .horizontal
        bannerPagerLayout.itemSize = CGSize(width: CGFloat(340), height: CGFloat(300))
        bannerPagerCollection = UICollectionView(frame: .zero, collectionViewLayout: bannerPagerLayout)
        bannerRankView.addSubViews(bannerTitleView, bannerImage, bannerLabel, bannerTopic, bannerSubTopic, bannerPagerCollection)
        bannerRankView.snp.makeConstraints { (make) in
            make.top.equalTo(pickView.snp.bottom).offset(0)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(680)
        }
        
        bannerTitleView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(40)
            make.top.equalTo(bannerRankView).offset(20)
        }
        
        bannerImage.image = UIImage(named: "gangnam")
        bannerImage.contentMode = .scaleToFill
        bannerImage.layer.cornerRadius = 10
        bannerImage.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(150)
            make.top.equalTo(bannerTitleView.snp.bottom).offset(10)
        }
        
        bannerLabel.text = "서울 역삼역 ' 퍼펙트라인의원"
        bannerLabel.textSizeAlignSet()
        bannerLabel.textAlignment = .left
        bannerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(15)
            make.top.equalTo(bannerImage.snp.bottom).offset(10)
        }
        
        bannerTopic.text = "2in1 골반 지방이식"
        bannerTopic.textSizeAlignSet()
        bannerTopic.textAlignment = .left
        bannerTopic.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(20)
            make.top.equalTo(bannerLabel.snp.bottom).offset(15)
        }
        
        bannerSubTopic.text = "복부 지방흡입과 고관절 지방이식을 동시에 하는 수술"
        bannerSubTopic.textSizeAlignSet()
        bannerSubTopic.textAlignment = .left
        bannerSubTopic.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(15)
            make.top.equalTo(bannerTopic.snp.bottom).offset(5)
        }
        
        bannerPagerCollection.showsHorizontalScrollIndicator = false
        bannerPagerCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        bannerPagerCollection.contentInsetAdjustmentBehavior = .never
        bannerPagerCollection.backgroundColor = .white
        bannerPagerCollection.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self)
            make.height.equalTo(350)
            make.top.equalTo(bannerSubTopic.snp.bottom).offset(0)
        }
        
    }
    
    public func setNavigationBarIconView() -> UIBarButtonItem{
        let iconView = UIView()
        
        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(340 * frame.width / 375)
            make.height.equalTo(39 * frame.height / 812)
        }
        
        iconView.addSubViews(searchTextField,alarmIcon,myPageIcon)
        searchTextField.addLeftPadding()
        searchTextField.textColor = .black
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.gray.cgColor
        searchTextField.layer.cornerRadius = 10
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요.",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        searchTextField.isEnabled = false
        searchTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(iconView.snp.leading)
            make.width.equalTo(250 * frame.width / 375)
            make.height.equalTo(35)
        }
        
        alarmIcon.image = UIImage(named: "alarmIcon")
        alarmIcon.contentMode = .scaleToFill
        alarmIcon.snp.makeConstraints { (make) in
            make.leading.equalTo(searchTextField.snp.trailing).offset(15)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(searchTextField.snp.centerY)
        }
        
        myPageIcon.image = UIImage(named: "mypageIcon")
        myPageIcon.contentMode = .scaleToFill
        myPageIcon.snp.makeConstraints { (make) in
            make.leading.equalTo(alarmIcon.snp.trailing).offset(15)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(searchTextField.snp.centerY)
        }
        
        return UIBarButtonItem(customView: iconView)
    }
}

