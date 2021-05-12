//
//  ImageSliderCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/25.
//

import Foundation
import UIKit
import SnapKit
class ImageSliderCell: UICollectionViewCell{
    lazy var imageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(150)
        }
        
    }
    public func setImage(image: UIImage){
        imageView.image = image
    }
}
