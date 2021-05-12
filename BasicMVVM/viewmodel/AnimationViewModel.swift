//
//  ViewModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/10.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType: class {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class AnimationViewModel: ViewModelType{
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let startAnimation = BehaviorRelay(value: false)
        let screenStatus = BehaviorRelay(value: ScreenStatus.splashView)
        
        input.after1Sec
            .subscribe(onNext: { _ in
                _ = Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance).take(1)
                    .subscribe(onDisposed:  {
                        startAnimation.accept(true)
                    })
            }).disposed(by: disposeBag)
        
        input.moveLogin
            .subscribe(onNext: { _ in
                screenStatus.accept(ScreenStatus.loginView)
            }).disposed(by: disposeBag)
        
        return Output(startAnimation: startAnimation.asDriver(), moveScreen: screenStatus.asDriver())
    }
    
    
    struct Input{
        var after1Sec: Observable<Void>
        var moveLogin: Observable<Void>
    }
    
    struct Output{
        var startAnimation: Driver<Bool>
        var moveScreen: Driver<ScreenStatus>
    }
    
}

enum ScreenStatus{
    case splashView
    case loginView
    case signInEmailView
    case signInPasswordView
    case homeView
}

enum TextInputState{
    case empty
    case usable
    case unusable
}

enum ViewLifeCycle{
    case start
    case viewDidLoad
}
