//
//  PasswordViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController

class SignInPasswordViewController: BaseViewController{
    lazy var passwordView: SinInPasswordView? = SinInPasswordView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "회원가입", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
    }
    
    override func setup() {
        view = passwordView
        
    }
    private var buttonUse: Bool = false
    private var buttonY: CGFloat = 0.0
    private var buttonMinY: CGFloat = 0.0
    
    private lazy var disposeBag = DisposeBag()
    private var viewModel = LoginViewModel()
    private lazy var input = LoginViewModel.Input(
        keyboardAddObserve: self.rx.viewDidAppear
            .asSignal()
            .map{_ in Void()}
            .asObservable(),
        endEditing: passwordView!.whiteView.rx
                .tapGesture()
                .map{_ in}
                .asObservable(),
        checkVaildPassword: passwordView!.passwordFiled.rx
                .text
                .orEmpty
                .distinctUntilChanged()
                .debounce(.seconds(Int(1)), scheduler: MainScheduler.instance)
                .map{String($0)}
                .asObservable(),
        checkPassword: passwordView!.passwordCheckFiled.rx
                .text
                .orEmpty
                .distinctUntilChanged()
                .debounce(.seconds(Int(1)), scheduler: MainScheduler.instance)
                .map{ [weak self] in return [self!.passwordView!.passwordFiled.text! , String($0)]}
                .asObservable(),
        startTouched: passwordView!.nextButton.rx
                .tap
                .map{_ in Void()}
                .asObservable())
    
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel(){
        
        output.keyboardObserveSet?.filter{$0 == 1}.drive{ [weak self] _ in
            self?.buttonMinY = (self?.passwordView?.nextButton.frame.minY)!
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        }.disposed(by: disposeBag)
        
        
        output.endEditingKeyboard?.drive{ [weak self] _ in
            self?.passwordView?.endEditing(true)
            
        }.disposed(by: disposeBag)
        
        
        output.isVaildPassword?.drive{ [weak self] (available) in
            self?.view.layoutIfNeeded()
            switch available{
            case .empty:
                self?.passwordView!.emptyTextUI(textFiled: (self?.passwordView?.passwordFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                break
                
            case .usable:
                self?.passwordView!.availableUI(textFiled: (self?.passwordView?.passwordFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                self?.buttonUse = true
                break
        
            case .unusable:
                self?.passwordView!.unavailableUI(textFiled: (self?.passwordView?.passwordFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                break
            }
        }.disposed(by: disposeBag)
            
        
        output.isCheckedPassword?.drive{ [weak self] (available) in
            self?.view.layoutIfNeeded()
            switch available{
            case .empty:
                self?.passwordView!.emptyTextUI(textFiled: (self?.passwordView?.passwordCheckFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableCheckLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                break
                
            case .usable:
                self?.passwordView!.availableUI(textFiled: (self?.passwordView?.passwordCheckFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableCheckLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                
                if self!.buttonUse{
                    self?.passwordView?.nextButton.isEnabled = true
                    self?.passwordView?.nextButton.backgroundColor = .orange
                }
                break
        
            case .unusable:
                self?.passwordView!.unavailableUI(textFiled: (self?.passwordView?.passwordCheckFiled)!,
                                                  noticeLabel: (self?.passwordView?.availableCheckLabel)!,
                                                  button: (self?.passwordView?.nextButton)!)
                break
            }
        }.disposed(by: disposeBag)
    
        output.moveScreen!.filter{$0 == .homeView}.drive { [weak self] (screen) in
            let homeViewController = self?.moveScreen(status: screen)
            NotificationCenter.default.removeObserver(self)
            
            let tabBarController = UITabBarController()
            
            tabBarController.addChild(homeViewController!)
            homeViewController!.tabBarItem = UITabBarItem(title: "홈", image: UIImage(), tag: 0)
            
            let reviewPage = ReviewPagerViewController()
            tabBarController.addChild(reviewPage)
            reviewPage.tabBarItem = UITabBarItem(title: "시술후기", image: UIImage(), tag: 1)
            
            let mainNav = UINavigationController()
            mainNav.pushViewController(tabBarController, animated: false)
            mainNav.modalPresentationStyle = .fullScreen
            
            self?.present(mainNav, animated: false, completion: mainNav.view.presentViewAnimationLeftToRight)
            
           
            
        }.disposed(by: disposeBag)
    }
    
    @objc
    func keyboardWillAppear(noti: Notification){
        let keyframe = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyframe.height
       
            UIView.animate(withDuration: 0) { [weak self] in
                guard let self = self else { return }
                self.passwordView?.nextButton.snp.updateConstraints { (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-height)
                }
                self.view.layoutIfNeeded()
                self.buttonY = (self.passwordView?.nextButton.frame.minY)!
        }
        
    }
    
    @objc
    func keyboardWillDisappear(noti: Notification){
        let keyframe = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyframe.height
            UIView.animate(withDuration: 0) { [weak self] in
                    guard let self = self else { return }
                    self.passwordView?.nextButton.snp.updateConstraints { (make) in
                        make.height.equalTo(40)
                        make.left.equalToSuperview().offset(10 * self.view.frame.width / 375)
                        make.right.equalToSuperview().offset(-10 * self.view.frame.width / 375)
                        make.bottom.equalToSuperview().offset((-20 * self.view.frame.height / 812) - 44)
                    }
            self.view.layoutIfNeeded()
        }
    }
    
}
