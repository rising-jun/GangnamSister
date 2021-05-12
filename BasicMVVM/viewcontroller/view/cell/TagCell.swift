//
//  TagCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/21.
//

import Foundation
import UIKit

class TagCell: UICollectionViewCell{
    lazy var grayView = UIView()
    lazy var shapLabel = UILabel()
    lazy var tagLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(grayView)
        grayView.backgroundColor = .lightGray
        grayView.addSubViews(shapLabel, tagLabel)
        
        grayView.snp.makeConstraints { (make) in
            make.height.equalTo(20)
        }
        
        shapLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(10)
            make.leading.equalTo(contentView.snp.leading).offset(5)
        }
        
        tagLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.leading.equalTo(shapLabel.snp.trailing).offset(5)
        }
        
        shapLabel.font = shapLabel.font.withSize(14)
        shapLabel.text = "#"
        shapLabel.textColor = .white
        tagLabel.font = shapLabel.font.withSize(16)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        
    }
}
