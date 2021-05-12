//
//  SplashView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/11.
//

import Foundation
import UIKit
import SnapKit
class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
    }
    
    
    public func emptyTextUI(textFiled: UITextField,noticeLabel: UILabel, button: UIButton){
        textFiled.layer.borderColor = UIColor.gray.cgColor
        noticeLabel.text = ""
        textFiled.reomoveErrorImg()
        button.backgroundColor = .gray
        button.isEnabled = false
    }
    
    public func availableUI(textFiled: UITextField,noticeLabel: UILabel, button: UIButton){
        button.isEnabled = true
        textFiled.layer.borderColor = UIColor.gray.cgColor
        noticeLabel.text = ""
        textFiled.reomoveErrorImg()
        button.backgroundColor = .orange
        
    }
    
    public func unavailableUI(textFiled: UITextField,noticeLabel: UILabel, button: UIButton){
        textFiled.layer.borderColor = UIColor.red.cgColor
        noticeLabel.text = "올바른 형식으로 입력해주세요."
        textFiled.createBorder()
        button.backgroundColor = .gray
        button.isEnabled = false
    }
}


class SplashView: BaseView{
    lazy var firstTitleLabel = UILabel()
    lazy var secondTitlelayer = UIView()
    lazy var secondTitleLabel = UILabel()
    lazy var thirdTitleLabel = UILabel()
    lazy var markLabel = UILabel()
    lazy var iconView = UIView()
    lazy var iconImageView = UIImageView()
    lazy var iconLabel = UILabel()
    
    override func setup() {
        super.setup()
        backgroundColor = .orange
        addSubViews(firstTitleLabel,secondTitlelayer,thirdTitleLabel,iconView)
        secondTitlelayer.addSubview(secondTitleLabel)
        secondTitlelayer.clipsToBounds = true
        iconView.addSubViews(iconImageView,iconLabel)
        
        firstTitleLabel.text = "언니를 만나고"
        
        firstTitleLabel.splashDefalutSetting()
        secondTitleLabel.splashDefalutSetting()
        iconLabel.text = "강남언니"
        iconLabel.splashDefalutSetting()
        
        //animationAfterPresenter()
        
        secondTitlelayer.layer.borderWidth = 5.0
        secondTitlelayer.layer.borderColor = UIColor.white.cgColor
        
        thirdTitleLabel.text = "고민은 끝났다"
        thirdTitleLabel.splashDefalutSetting()
        
        
        secondTitlelayer.snp.makeConstraints { (make) in
            make.center.equalTo(center)
            make.width.equalTo(300 * frame.width / 375)
            make.height.equalTo(80 * frame.height / 812)
        }
        
        secondTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(200 * frame.width / 375)
            make.top.equalTo(secondTitlelayer.snp.top).offset(10 * frame.height / 812)
            make.bottom.equalTo(secondTitlelayer.snp.bottom).offset(-5 * frame.height / 812)
        }
        
        firstTitleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(300 * frame.width / 375)
            make.height.equalTo(80 * frame.height / 812)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(secondTitlelayer.snp.top).offset(-10 * frame.height / 812)
            
        }
        
        thirdTitleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(300 * frame.width / 375)
            make.height.equalTo(80 * frame.height / 812)
            make.centerX.equalToSuperview()
            make.top.equalTo(secondTitlelayer.snp.bottom).offset(15 * frame.height / 812)
        }

        iconView.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
        }
        
        iconImageView.image = UIImage(named: "healingPaper")
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.snp.makeConstraints { (make) in
            make.width.equalTo(25 * frame.width / 375)
            make.height.equalTo(25 * frame.height / 812)
            make.centerY.equalTo(iconView)
        }
        
        iconLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
            make.centerY.equalTo(iconView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5 * frame.width / 375)
        }
        
        
    }
}
