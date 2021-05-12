//
//  UI.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/11.
//

import Foundation
import UIKit

extension UILabel{
    
    
    func splashDefalutSetting(){
        textColor = .white
        font = UIFont(name: "BMDoHyeon", size: 100)
        textSizeAlignSet()
        textColor = .white
    }
    
    final func textSizeAlignSet(){
        font = UIFont.boldSystemFont(ofSize: 100)
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        minimumScaleFactor = 0.1
        textColor = .black
    }
    final func fillViewtoSize(){
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
    
    final func animate(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.type = CATransitionType.moveIn
        animation.subtype = CATransitionSubtype.fromBottom
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fillMode = CAMediaTimingFillMode.removed
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func introLabel(text: String, lineHeightMultiply: CGFloat) {
        textSizeAlignSet()
        let paragraphStyle = NSMutableParagraphStyle()
        //line height size
        paragraphStyle.lineSpacing = lineHeightMultiply
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        attributedText = attrString
        lineBreakMode = NSLineBreakMode.byTruncatingTail
        numberOfLines = 3
        textAlignment = .left
    }
    
}

extension UIView{
    
    func backgroundView() -> UIView{
        let bv = UIView(frame: self.frame)
        addSubview(bv)
        return bv
    }
    
    func presentViewAnimationLeftToRight(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        window!.layer.add(transition, forKey: kCATransition)
    }
    
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func setTextSizeAligns(_ labels: UILabel...){
        for label in labels {
            label.textSizeAlignSet()
            label.textAlignment = .left
        }
    }
    
    func getTitleLabel(title: String) -> UIView{
        var view = UIView(frame: frame)
        var titleLabel = UILabel()
        var rightLabel = UILabel()
        view.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width)
            make.height.equalTo(40)
        }
        view.addSubViews(titleLabel, rightLabel)
        
        rightLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        titleLabel.text = title
        titleLabel.textSizeAlignSet()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        return view
    }
    
    func addBottomBorderWithColor() -> UIView {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }

    
}


extension UINavigationBar{
    final func setColorWithView(){
        barTintColor = .white
        shadowImage = UIImage()
        isTranslucent = false
    }
}

extension UIScrollView{
    final func setDefalutView(){
        contentSize.width = frame.width
        contentSize.height = frame.height * 2
        isScrollEnabled = true
        alwaysBounceVertical = true
        
    }
}

extension UITextField{
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func reomoveErrorImg(){
        rightView = nil
    }
    
    func createBorder(){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let errorImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        errorImg.image = UIImage(named: "error")
        errorImg.contentMode = .scaleAspectFit
        rightView.addSubview(errorImg)
        let rightPadding: CGFloat = 20 //--- change right padding
        rightView.frame = CGRect(x: 0, y: 0, width: errorImg.frame.size.width + rightPadding , height: errorImg.frame.size.height)
        self.rightView = rightView
        self.rightViewMode = .always
    }
}

