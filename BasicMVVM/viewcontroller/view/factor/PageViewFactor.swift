//
//  PageViewFactor.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/06.
//

import Foundation
import UIKit

class PageViewFactor: UIView{
    lazy var viewTitleLabel = UILabel()
    lazy var myPageIcon = UIImageView()
    lazy var alarmIcon = UIImageView()
    lazy var pencilIcon = UIImageView()
    //lazy var compareButton = UIButton()
    
    
    private var collectionView: UICollectionView!

    
    public func menuCollectionView() -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "menuCell")
        return collectionView
    }
    
    public func setNavigationBarIconView(frame: CGRect, compareButton: UIButton) -> UIBarButtonItem{
        let iconView = UIView(frame: frame)
        
        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(340 * frame.width / 375)
            make.height.equalTo(39 * frame.height / 812)
        }
        
        iconView.addSubViews(viewTitleLabel, alarmIcon, myPageIcon, pencilIcon, compareButton)
    
        viewTitleLabel.text = "시술후기"
        viewTitleLabel.textColor = .black
        viewTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        viewTitleLabel.textAlignment = .left
        viewTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView).offset(2)
            make.bottom.equalTo(iconView).offset(-2)
            make.leading.equalTo(iconView).offset(5)
            make.width.equalTo(150)
        }
        
        pencilIcon.image = UIImage(named: "pencil")
        pencilIcon.contentMode = .scaleToFill
        pencilIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(iconView).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        alarmIcon.image = UIImage(named: "alarmIcon")
        alarmIcon.contentMode = .scaleToFill
        alarmIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(pencilIcon.snp.leading).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        myPageIcon.image = UIImage(named: "mypageIcon")
        myPageIcon.contentMode = .scaleToFill
        myPageIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(alarmIcon.snp.leading).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        compareButton.setTitle("비교", for: .normal)
        compareButton.setTitleColor(.blue, for: .normal)
        compareButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        compareButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(myPageIcon.snp.leading).offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(viewTitleLabel.snp.centerY)
        }
        
        
        return UIBarButtonItem(customView: iconView)
    }

}
