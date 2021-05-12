//
//  BannerCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/24.
//

import Foundation
import UIKit

class BannerCell: UICollectionViewCell{
    lazy var imageView = UIImageView()
    lazy var infoLabel = UILabel()
    lazy var titleLabel = UILabel()
    lazy var subTitleLabel = UILabel()
    lazy var scoreLabel = UILabel()
    lazy var priceLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var view = UIView()
        
        view.setTextSizeAligns(infoLabel, titleLabel, subTitleLabel, scoreLabel ,priceLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.equalTo(320)
            make.height.equalTo(85)
        }
        
        view.addSubViews(imageView, infoLabel, titleLabel, subTitleLabel, scoreLabel, priceLabel)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.width.equalTo(235)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.width.equalTo(235)
            make.height.equalTo(19)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.width.equalTo(235)
            make.height.equalTo(10)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.width.equalTo(235)
            make.height.equalTo(10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.width.equalTo(235)
            make.height.equalTo(20)
        }
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        
    }
}
