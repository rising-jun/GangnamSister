//
//  ReviewImageCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/26.
//

import Foundation
import UIKit

class ReviewImageCell: UICollectionViewCell{
    lazy var imageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(125)
            make.height.equalTo(125)
        }
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        
    }
    public func setImage(image: UIImage){
        imageView.image = image
    }

}
