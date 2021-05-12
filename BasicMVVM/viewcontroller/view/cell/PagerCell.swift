//
//  PagerCell.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/11.
//

import Foundation
import UIKit
import SnapKit

class PagerCell: UICollectionViewCell{
    lazy var view = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(contentView)
        }
        
    }
    
}
