//
//  BeforeAfterCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/16.
//

import Foundation
import UIKit

class BeforeAfterCell: UICollectionViewCell{
    lazy var imageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        
    }
    public func setImage(image: UIImage){
        imageView.image = image
    }
    
}
