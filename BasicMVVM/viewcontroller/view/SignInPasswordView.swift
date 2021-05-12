//
//  SignInPasswordView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/16.
//

import Foundation
import UIKit
import SnapKit

class SinInPasswordView: BaseView{
    
    lazy var scrollView = UIScrollView()
    private lazy var passwordLabel = UILabel()
    lazy var passwordFiled = UITextField()
    lazy var availableLabel = UILabel()
    lazy var whiteView = UIView()
    
    private lazy var passwordCheckLabel = UILabel()
    lazy var passwordCheckFiled = UITextField()
    lazy var availableCheckLabel = UILabel()
    
    lazy  var nextButton: UIButton = {
        let nextButton = UIButton(frame: .zero)
        nextButton.autoresizingMask = .flexibleHeight
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .gray
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("다음", for: .normal)
        return nextButton
    }()
    
    
    override func setup() {
        super.setup()
        
        scrollView.setDefalutView()
        addSubViews(scrollView,nextButton)
        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubViews(passwordLabel,passwordFiled,whiteView,availableLabel,passwordCheckLabel,passwordCheckFiled,availableCheckLabel)
        scrollView.sendSubviewToBack(whiteView)
        
        passwordLabel.text = "비밀번호"
        passwordLabel.textColor = .black
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 16)
        passwordLabel.fillViewtoSize()
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(20 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(50 * frame.width / 375)
            make.height.equalTo(30 * frame.height / 812)
        }
        
        passwordFiled.addLeftPadding()
        passwordFiled.isSecureTextEntry = true
        passwordFiled.textColor = .black
        passwordFiled.layer.borderWidth = 1
        passwordFiled.layer.borderColor = UIColor.gray.cgColor
        passwordFiled.layer.cornerRadius = 10
        passwordFiled.attributedPlaceholder = NSAttributedString(string: "영문 숫자 특수문자 포함 8~16자로 조합해주세요.",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(812)
        }
        passwordFiled.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(1 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
        }
        
        availableLabel.textColor = .red
        availableLabel.fillViewtoSize()
        availableLabel.font = UIFont.boldSystemFont(ofSize: 12)
        availableLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordFiled.snp.bottom).offset(5 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(35 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(10 * frame.height / 812)
            
        }
        
        passwordCheckLabel.text = "비밀번호 확인"
        passwordCheckLabel.textColor = .black
        passwordCheckLabel.font = UIFont.boldSystemFont(ofSize: 16)
        passwordCheckLabel.fillViewtoSize()
        passwordCheckLabel.snp.makeConstraints { (make) in
            make.top.equalTo(availableLabel.snp.bottom).offset(20 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(100 * frame.width / 375)
            make.height.equalTo(30 * frame.height / 812)
        }
        
        passwordCheckFiled.addLeftPadding()
        passwordCheckFiled.isSecureTextEntry = true
        passwordCheckFiled.textColor = .black
        passwordCheckFiled.layer.borderWidth = 1
        passwordCheckFiled.layer.borderColor = UIColor.gray.cgColor
        passwordCheckFiled.layer.cornerRadius = 10
        passwordCheckFiled.attributedPlaceholder = NSAttributedString(string: "한 번 더 입력해주세요.",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        passwordCheckFiled.snp.makeConstraints { (make) in
            make.top.equalTo(passwordCheckLabel.snp.bottom).offset(1 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
        }
        
        availableCheckLabel.textColor = .red
        availableCheckLabel.fillViewtoSize()
        availableCheckLabel.font = UIFont.boldSystemFont(ofSize: 12)
        availableCheckLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordCheckFiled.snp.bottom).offset(5 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(35 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(10 * frame.height / 812)
            
        }
        
        
        nextButton.snp.remakeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(10 * frame.width / 375)
            make.right.equalToSuperview().offset(-10 * frame.width / 375)
            make.bottom.equalToSuperview().offset((-20 * frame.height / 812) - 44)
        }
    
    }
    
    override func emptyTextUI(textFiled: UITextField, noticeLabel: UILabel, button: UIButton) {
        super.emptyTextUI(textFiled: textFiled, noticeLabel: noticeLabel, button: button)
    }
    
    override func availableUI(textFiled: UITextField, noticeLabel: UILabel, button: UIButton) {
        super.availableUI(textFiled: textFiled, noticeLabel: noticeLabel, button: button)
        button.isEnabled = false
        button.backgroundColor = .gray
    }
    
    override func unavailableUI(textFiled: UITextField, noticeLabel: UILabel, button: UIButton) {
        super.unavailableUI(textFiled: textFiled, noticeLabel: noticeLabel, button: button)
    }

}
