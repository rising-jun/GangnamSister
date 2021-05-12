//
//  LoginViewModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/12.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType{
    
    private var disposeBag = DisposeBag()
    public static var userInfo = UserInfo()
    
    func transform(input: Input) -> Output {
        
        let keyboardObserve = BehaviorRelay(value: 0)
        input.keyboardAddObserve?.subscribe{_ in
            keyboardObserve.accept(keyboardObserve.value + 1)
        }.disposed(by: disposeBag)
        
        let endEditingKeyboard = BehaviorRelay(value: 0)
        input.endEditing?.subscribe{ _ in
            endEditingKeyboard.accept(endEditingKeyboard.value)
        }.disposed(by: disposeBag)
        
        let screenStatus = BehaviorRelay(value: ScreenStatus.loginView)
        input.loginTouched?.subscribe { _ in
            screenStatus.accept(ScreenStatus.signInEmailView)
        }.disposed(by: disposeBag)
        
        let vaildCheck = BehaviorRelay(value: TextInputState.empty)
        input.checkValidEmail?.subscribe{ (email) in
            var val = email.element
            if val == ""{
                vaildCheck.accept(.empty)
            }else{
                if self.isValidEmail(testStr: val!){
                    vaildCheck.accept(.usable)
                }else{
                    vaildCheck.accept(.unusable)
                }
            }
        }.disposed(by: disposeBag)
        
        let checkPassword = BehaviorRelay(value: TextInputState.empty)
        input.emailTouched?.subscribe{ (email) in
            LoginViewModel.userInfo.userId_ = email.element ?? ""
            screenStatus.accept(ScreenStatus.signInPasswordView)
        }.disposed(by: disposeBag)
        
        input.checkVaildPassword?.subscribe{ (password) in
            let val = password.element ?? ""
            if val == ""{
                vaildCheck.accept(.empty)
            }else{
                if self.isValidPassword(testStr: val){
                    vaildCheck.accept(.usable)
                }else{
                    vaildCheck.accept(.unusable)
                }
            }
            
        }.disposed(by: disposeBag)
        
        input.checkPassword?.subscribe{ (passwordEvent) in
            let password = passwordEvent.element ?? ["" , ""]
            if password.count == 1{
                checkPassword.accept(.empty)
            }else{
                if password[0] == password[1]{
                    checkPassword.accept(.usable)
                }else{
                    checkPassword.accept(.unusable)
                }
            }
        }.disposed(by: disposeBag)
        
        input.startTouched?.subscribe{ _ in
            screenStatus.accept(.homeView)
        }.disposed(by: disposeBag)
        
        return Output(moveScreen: screenStatus.asDriver(),
                      keyboardObserveSet: keyboardObserve.asDriver(),
                      endEditingKeyboard: endEditingKeyboard.asDriver(),
                      isValidEmail: vaildCheck.asDriver(),
                      isVaildPassword: vaildCheck.asDriver(),
                      isCheckedPassword: checkPassword.asDriver())
    }
    
    struct Input{
        var keyboardAddObserve: Observable<Void>?
        var endEditing: Observable<Void>?
        var loginTouched: Observable<Void>?
        
        var emailTouched: Observable<String>?
        var checkValidEmail: Observable<String>?
        
        var checkVaildPassword: Observable<String>?
        var checkPassword: Observable<[String]>?
        
        var startTouched: Observable<Void>?
    }
    
    struct Output{
        var moveScreen: Driver<ScreenStatus>?
        
        var keyboardObserveSet: Driver<Int>?
        var endEditingKeyboard: Driver<Int>?
        
        var isValidEmail: Driver<TextInputState>?
        
        var isVaildPassword: Driver<TextInputState>?
        var isCheckedPassword: Driver<TextInputState>?
        
    }
    
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func isValidPassword(testStr:String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@$&#]).{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: testStr)
    }
}
