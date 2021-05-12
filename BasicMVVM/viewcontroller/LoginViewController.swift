//
//  LoginViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/12.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController{
    lazy var loginView: LoginView = LoginView(frame: view.bounds)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presentedViewController?.dismiss(animated: false, completion: nil)
        navigationController?.navigationBar.setColorWithView()
        self.navigationItem.leftBarButtonItem = loginView.setNavigationBarIconView()
        self.navigationItem.rightBarButtonItem = loginView.setNavigationBarInquiryLabel()
    }
    
    override func setup() {
        super.setup()
        view = loginView
    }
    
    private var disposeBag = DisposeBag()
    private var viewModel = LoginViewModel()
    private lazy var input = LoginViewModel
        .Input(loginTouched: loginView.emailButton.rx.tap.asObservable())
        
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.moveScreen!.filter{$0 == .signInEmailView}.drive { [weak self] (screen) in
            //TODO 로그인여부에 따라 mainView or loginView로 present
            let signInEmailViewController = self?.moveScreen(status: screen)
            self?.view.presentViewAnimationLeftToRight()
            self?.navigationController?.pushViewController(signInEmailViewController!, animated: true)
            
        }.disposed(by: disposeBag)
        
    
    }
    
}
