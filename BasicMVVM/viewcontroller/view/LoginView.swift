//
//  LoginView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/12.
//

import Foundation
import UIKit

class LoginView: BaseView{
    
    lazy var iconImageView = UIImageView()
    lazy var iconLabel = UILabel()
    
    lazy var inquiryLabel = UILabel()
    
    var iconBarItem: UIBarButtonItem?
    var inquiryBtnItem: UIBarButtonItem?
    
    lazy var scrollView = UIScrollView()
    
    lazy var introLabel = UILabel()
    lazy var subIntroLabel = UILabel()
    lazy var kakaoButton = UIButton()
    lazy var faceButton = UIButton()
    lazy var lineButton = UIButton()
    lazy var appleButton = UIButton()
    lazy var emailButton = UIButton()
    
    lazy var orView = UIStackView()
    lazy var lineView = UIView()
    lazy var orLabel = UILabel()
    
    override func setup() {
        super.setup()
    
        scrollView.setDefalutView()
        addSubview(scrollView)
        scrollView.addSubViews(introLabel, subIntroLabel, kakaoButton, faceButton, lineButton, appleButton, orView, emailButton)

        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
            
        }
        
        introLabel.introLabel(text: "NO.1 성형 전문가 \n강남언니에 오신 것을 \n환영합니다! ", lineHeightMultiply: 15)
        introLabel.textColor = .black
        introLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(40 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).inset(20 * frame.width / 375)
            make.width.equalTo(160 * frame.width / 375)
            make.height.equalTo(100 * frame.height / 812)
        }
        
        subIntroLabel.textSizeAlignSet()
        subIntroLabel.text = "가입정보는 SNS로 공유되지 않으니 걱정마세요. 😘"
        subIntroLabel.textColor = .black
        subIntroLabel.font = UIFont.systemFont(ofSize: 100)
        subIntroLabel.snp.makeConstraints { (make) in
            make.top.equalTo(introLabel.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).inset(20 * frame.width / 375)
            make.width.equalTo(270 * frame.width / 375)
            make.height.equalTo(30 * frame.height / 812)
        }
        
        kakaoButton.setImage(UIImage(named: "kakaoLogin"), for: .normal)
        kakaoButton.imageView?.contentMode = .scaleAspectFill
        kakaoButton.contentVerticalAlignment = .fill
        kakaoButton.contentHorizontalAlignment = .fill
        kakaoButton.snp.makeConstraints { (make) in
            make.top.equalTo(subIntroLabel.snp.bottom).offset(120 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }
        
        
        faceButton.setImage(UIImage(named: "facebookLogin"), for: .normal)
        faceButton.imageView?.contentMode = .scaleAspectFill
        faceButton.contentVerticalAlignment = .fill
        faceButton.contentHorizontalAlignment = .fill
        faceButton.snp.makeConstraints { (make) in
            make.top.equalTo(kakaoButton.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }
        
        lineButton.setImage(UIImage(named: "lineLogin"), for: .normal)
        lineButton.imageView?.contentMode = .scaleAspectFit
        lineButton.contentVerticalAlignment = .fill
        lineButton.contentHorizontalAlignment = .fill
        lineButton.snp.makeConstraints { (make) in
            make.top.equalTo(faceButton.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }
        
        appleButton.setImage(UIImage(named: "appleLogin"), for: .normal)
        appleButton.imageView?.contentMode = .scaleAspectFill
        appleButton.contentVerticalAlignment = .fill
        appleButton.contentHorizontalAlignment = .fill
        appleButton.snp.makeConstraints { (make) in
            make.top.equalTo(lineButton.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }

        //orView.addSubview(orLabel)
        orView.addSubViews(lineView, orLabel)
        orView.snp.makeConstraints { (make) in
            make.top.equalTo(appleButton.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }
        
        lineView.backgroundColor = .gray
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(orView.snp.width)
            make.height.equalTo(0.5 * frame.height / 812)
            make.centerY.equalTo(orView.snp.centerY)
        }
        
        orLabel.text = "또는"
        orLabel.backgroundColor = .white
        orLabel.textAlignment = .center
        orLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
            make.leading.equalTo(orView.snp.leading).inset(142.5 * frame.width / 375)
        }
       
        emailButton.setTitle("   @   이메일로 시작", for: .normal)
        emailButton.setTitleColor(.black, for: .normal)
        emailButton.titleLabel?.textAlignment = .left
        emailButton.contentHorizontalAlignment = .left
        emailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        emailButton.layer.cornerRadius = 10
        emailButton.layer.shadowColor = UIColor.gray.cgColor
        emailButton.layer.shadowOpacity = 0.5
        emailButton.layer.shadowRadius = 10
        emailButton.backgroundColor = .white
        emailButton.snp.makeConstraints { (make) in
            make.top.equalTo(orLabel.snp.bottom).offset(10 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(50 * frame.height / 812)
        }
        
    }
    
    public func setNavigationBarIconView() -> UIBarButtonItem{
        
        let iconView = UIView()
        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(150 * frame.width / 375)
            make.height.equalTo(39 * frame.height / 812)
        }
        iconView.addSubViews(iconImageView,iconLabel)
        
        iconImageView.image = UIImage(named: "healingPaper")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { (make) in
            make.width.equalTo(25 * frame.width / 375)
            make.height.equalTo(25 * frame.height / 812)
            make.centerY.equalTo(iconView)
        }

        iconLabel.text = "강남언니"
        iconLabel.splashDefalutSetting()
        iconLabel.textColor = .orange
        iconLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
            make.centerY.equalTo(iconView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5 * frame.width / 375)
        }
        
        return UIBarButtonItem(customView: iconView)
    }
    
    public func setNavigationBarInquiryLabel() -> UIBarButtonItem{
        inquiryLabel.text = "고객문의"
        inquiryLabel.textSizeAlignSet()
        inquiryLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50 * frame.width / 375)
            make.height.equalTo(25 * frame.height / 812)
            
        }
        return UIBarButtonItem(customView: inquiryLabel)
    }
    
    

}
