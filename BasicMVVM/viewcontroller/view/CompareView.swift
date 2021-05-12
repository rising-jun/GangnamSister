//
//  CompareView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/02/05.
//

import Foundation
import UIKit
import SnapKit

class CompareView: BaseView{
    lazy var line = UIView()
    
    lazy var imageView1 = UIImageView()
    lazy var imageView2 = UIImageView()
    
    lazy var tagLabel = UILabel()
    lazy var tagLabel1 = UILabel()
    lazy var tagLabel2 = UILabel()
    
    lazy var priceLabel = UILabel()
    lazy var priceLabel1 = UILabel()
    lazy var priceLabel2 = UILabel()
    lazy var priceNotice = UILabel()
    
    lazy var locLabel = UILabel()
    lazy var locLabel1 = UILabel()
    lazy var locLabel2 = UILabel()
    
    lazy var docLabel = UILabel()
    lazy var docLabel1 = UILabel()
    lazy var docLabel2 = UILabel()
    
    lazy var heartLabel = UILabel()
    lazy var heartLabel1 = UILabel()
    lazy var heartLabel2 = UILabel()
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubViews(imageView1, imageView2, tagLabel, tagLabel1, tagLabel2, priceLabel, priceLabel1, priceLabel2, priceNotice, locLabel, locLabel1, locLabel2, docLabel, docLabel1, docLabel2, heartLabel, heartLabel1, heartLabel2)
        
        imageView1.snp.makeConstraints { (make) in
            make.height.width.equalTo(180)
            make.top.equalTo(self.snp.top).offset(80)
            make.leading.equalTo(self.snp.leading).offset(15)
        }
        
        imageView2.snp.makeConstraints { (make) in
            make.height.width.equalTo(180)
            make.top.equalTo(self.snp.top).offset(80)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
        }
        
        tagLabel.text = "성형 부위"
        tagLabel.textSizeAlignSet()
        tagLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView1.snp.bottom).offset(50)
        }
        
        tagLabel1.textSizeAlignSet()
        tagLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.centerX.equalTo(imageView1.snp.centerX)
            make.centerY.equalTo(tagLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        tagLabel2.textSizeAlignSet()
        tagLabel2.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.centerX.equalTo(imageView2.snp.centerX)
            make.centerY.equalTo(tagLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        priceLabel.text = "가격"
        priceLabel.textSizeAlignSet()
        priceLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(tagLabel.snp.bottom).offset(30)
        }
        
        priceLabel1.textSizeAlignSet()
        priceLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView1.snp.centerX)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        priceLabel2.textSizeAlignSet()
        priceLabel2.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView2.snp.centerX)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        priceNotice.textSizeAlignSet()
        priceNotice.text = "*시술 방식 및 가격은 개인 특성에 따라 달라질 수 있습니다."
        priceNotice.textColor = .brown
        priceNotice.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(15)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }
        
        locLabel.textSizeAlignSet()
        locLabel.text = "위치"
        locLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(priceNotice.snp.bottom).offset(30)
        }
        
        locLabel1.textSizeAlignSet()
        locLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView1.snp.centerX)
            make.centerY.equalTo(locLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        locLabel2.textSizeAlignSet()
        locLabel2.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView2.snp.centerX)
            make.centerY.equalTo(locLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        docLabel.textSizeAlignSet()
        docLabel.text = "전문의"
        docLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(locLabel.snp.bottom).offset(30)
        }
        
        docLabel1.textSizeAlignSet()
        docLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView1.snp.centerX)
            make.centerY.equalTo(docLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        docLabel2.textSizeAlignSet()
        docLabel2.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView2.snp.centerX)
            make.centerY.equalTo(docLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        heartLabel.textSizeAlignSet()
        heartLabel.text = "좋아요"
        heartLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(docLabel.snp.bottom).offset(30)
        }
        
        heartLabel1.textSizeAlignSet()
        heartLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView1.snp.centerX)
            make.centerY.equalTo(heartLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
        heartLabel2.textSizeAlignSet()
        heartLabel2.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.centerX.equalTo(imageView2.snp.centerX)
            make.centerY.equalTo(heartLabel.snp.centerY)
            make.height.equalTo(25)
        }
        
    }
    
    public func setfirstInfoUI(reviewInfo: ReviewInfo){
        imageView1.image = reviewInfo.imageArr_[1]
        docLabel1.text = reviewInfo.doc_
        heartLabel1.text = reviewInfo.heart_ + "개"
        priceLabel1.text = reviewInfo.price_ + "만원"
        var tag = ""
        for i in reviewInfo.tagArr_{
            tag.append(i+" ")
        }
        tagLabel1.text = tag
        locLabel1.text = reviewInfo.loc_
        
        if reviewInfo.heartColor_ == .Red{
            heartLabel1.textColor = .red
        }else{
            heartLabel1.textColor = .blue
        }
        
        if reviewInfo.priceColor_ == .Red{
            priceLabel1.textColor = .red
        }else{
            priceLabel1.textColor = .blue
        }
    }
    
    public func setSecondInfoUI(reviewInfo: ReviewInfo){
        imageView2.image = reviewInfo.imageArr_[1]
        docLabel2.text = reviewInfo.doc_
        heartLabel2.text = reviewInfo.heart_ + "개"
        priceLabel2.text = reviewInfo.price_ + "만원"
        var tag = ""
        for i in reviewInfo.tagArr_{
            tag.append(i+" ")
        }
        tagLabel2.text = tag
        locLabel2.text = reviewInfo.loc_
        
        if reviewInfo.heartColor_ == .Red{
            heartLabel2.textColor = .red
        }else{
            heartLabel2.textColor = .blue
        }
        
        if reviewInfo.priceColor_ == .Red{
            priceLabel2.textColor = .red
        }else{
            priceLabel2.textColor = .blue
        }
    }
}
