//
//  SingInEmailViewController.swift
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

class SignInEmailViewController: BaseViewController{
    
    lazy var signInEmailView: SignInEmailView = SignInEmailView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이메일로 시작하기", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        
    }
    
    override func setup() {
        super.setup()
        view = signInEmailView
    }
    
    private var disposeBag = DisposeBag()
    private var viewModel = LoginViewModel()
    private lazy var input = LoginViewModel
        .Input(keyboardAddObserve: rx.viewWillAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
               endEditing: signInEmailView.rx
                .tapGesture()
                .map{_ in}
                .asObservable(),
               emailTouched: signInEmailView.nextButton.rx
                .tap
                .map{self.signInEmailView.emailFiled.text!}
                .asObservable(),
               checkValidEmail: signInEmailView.emailFiled.rx
                .text
                .orEmpty
                .distinctUntilChanged()
                .debounce(.seconds(Int(1)), scheduler: MainScheduler.instance)
                .map{String($0)}
                .asObservable())
        
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.keyboardObserveSet?.drive{ [weak self] _ in
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        }.disposed(by: disposeBag)
        
        output.endEditingKeyboard?.drive{ [weak self] _ in
            self?.signInEmailView.emailFiled.endEditing(true)
        }.disposed(by: disposeBag)
        
        output.isValidEmail?.drive{[weak self] (available) in
            switch available{
                case .empty:
                    self?.signInEmailView.emptyTextUI(textFiled: (self?.signInEmailView.emailFiled)!,
                                                      noticeLabel: (self?.signInEmailView.availableLabel)!,
                                                      button: (self?.signInEmailView.nextButton)!)
                    break
                    
                case .usable:
                    self?.signInEmailView.availableUI(textFiled: (self?.signInEmailView.emailFiled)!,
                                                      noticeLabel: (self?.signInEmailView.availableLabel)!,
                                                      button: (self?.signInEmailView.nextButton)!)
                    break
            
                case .unusable:
                    self?.signInEmailView.unavailableUI(textFiled: (self?.signInEmailView.emailFiled)!,
                                                        noticeLabel: (self?.signInEmailView.availableLabel)!,
                                                        button: (self?.signInEmailView.nextButton)!)
                    break
            }
            
            
        }.disposed(by: disposeBag)
        
        output.moveScreen!.filter{$0 == .signInPasswordView}.drive { [weak self] (screen) in
            let singInEmailViewController = self?.moveScreen(status: screen)
            NotificationCenter.default.removeObserver(self)
            self?.view.presentViewAnimationLeftToRight()
            self?.navigationController?.pushViewController(singInEmailViewController!, animated: true)
        }.disposed(by: disposeBag)
        
        
    }
    
    @objc
    func keyboardWillAppear(noti: Notification){
        UIView.animate(withDuration: 3) { [weak self] in
            guard let self = self else { return }
            self.signInEmailView.nextButton.snp.updateConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-346)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc
    func keyboardWillDisappear(noti: Notification){
        UIView.animate(withDuration: 3) { [weak self] in
            guard let self = self else { return }
            self.signInEmailView.nextButton.snp.updateConstraints { (make) in
                make.height.equalTo(40)
                make.left.equalToSuperview().offset(10 * self.view.frame.width / 375)
                make.right.equalToSuperview().offset(-10 * self.view.frame.width / 375)
                make.bottom.equalToSuperview().offset((-20 * self.view.frame.height / 812) - 44)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}
