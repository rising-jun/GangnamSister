//
//  SignInEmailView.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/16.
//

import Foundation
import UIKit
import SnapKit
class SignInEmailView: BaseView{
    
    lazy var scrollView = UIScrollView()
    private lazy var emailLabel = UILabel()
    lazy var emailFiled = UITextField()
    lazy var availableLabel = UILabel()
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
        scrollView.addSubViews(emailLabel,emailFiled,availableLabel)
        
        
        emailLabel.text = "이메일"
        emailLabel.textColor = .black
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.fillViewtoSize()
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(20 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(50 * frame.width / 375)
            make.height.equalTo(30 * frame.height / 812)
        }
        
        emailFiled.addLeftPadding()
        emailFiled.textColor = .black
        emailFiled.layer.borderWidth = 1
        emailFiled.layer.borderColor = UIColor.gray.cgColor
        emailFiled.layer.cornerRadius = 10
        emailFiled.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        emailFiled.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(1 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(20 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(40 * frame.height / 812)
        }
        
        availableLabel.textColor = .red
        availableLabel.fillViewtoSize()
        availableLabel.font = UIFont.boldSystemFont(ofSize: 12)
        availableLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailFiled.snp.bottom).offset(5 * frame.height / 812)
            make.leading.equalTo(scrollView.snp.leading).offset(35 * frame.width / 375)
            make.width.equalTo(335 * frame.width / 375)
            make.height.equalTo(10 * frame.height / 812)
            
        }
        
        nextButton.snp.remakeConstraints { (make) in
            //make.width.equalTo(350 * view.frame.width / 375)
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
    }
    
    override func unavailableUI(textFiled: UITextField, noticeLabel: UILabel, button: UIButton) {
        super.unavailableUI(textFiled: textFiled, noticeLabel: noticeLabel, button: button)
    }

}
