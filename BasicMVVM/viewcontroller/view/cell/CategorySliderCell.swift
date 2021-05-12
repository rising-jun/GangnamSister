//
//  CategorySliderCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/04.
//

import Foundation
import UIKit

class CategorySliderCell: UICollectionViewCell{
    lazy var view = UIView()
    lazy var categoryImageView = UIImageView()
    lazy var categoryLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(view)
        view.addSubViews(categoryImageView, categoryLabel)
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(60)
            make.leading.equalTo(contentView.snp.leading).offset(5)
        }
        
        categoryImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(5)
            make.bottom.equalTo(categoryLabel.snp.top).offset(-5)
            make.width.equalTo(50)
            make.leading.equalTo(view).offset(5)
            
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.width.equalTo(view)
            make.height.equalTo(25)
            make.bottom.equalTo(view).offset(-5)
        }
        
        categoryImageView.contentMode = .scaleToFill
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .black
        categoryLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    public func setCellData(icon: UIImage,category: String){
        categoryImageView.image = icon
        categoryLabel.text = category
    }
    
}
