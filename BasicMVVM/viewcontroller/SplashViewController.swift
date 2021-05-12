//
//  ViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import RxAnimated

class BaseViewController: UIViewController{
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    public func setup() {
        view.backgroundColor = .white
        
    }
        
    public func bindViewModel(){
    }
    
    public func moveScreen(status : ScreenStatus) -> BaseViewController{
        var controller: BaseViewController
        switch status{
        case .loginView:
            controller = LoginViewController()
            break
        case .splashView:
            controller = SplashViewController()
            break
        case .signInEmailView:
            controller = SignInEmailViewController()
            break
        case .signInPasswordView:
            controller = SignInPasswordViewController()
            break
            
        case .homeView:
            controller = HomeViewController()
            break
        }
        
        return controller
    }
    
}

class SplashViewController: BaseViewController {
    
    private var viewModel = AnimationViewModel()
    private var disposeBag = DisposeBag()
    private var animationDone = PublishSubject<Bool>()

    lazy var splashView: SplashView = SplashView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func setup() {
        super.setup()
        view = splashView
    }
    
    private lazy var input = AnimationViewModel
        .Input(after1Sec: rx.viewWillAppear.asSignal()
                .map{_ in Void()}.asObservable(),
               moveLogin: animationDone.distinctUntilChanged().filter{$0 == true}.map{_ in Void()}.asObservable())

    private lazy var output = viewModel.transform(input: input)
    
    
    override func bindViewModel() {
        super.bindViewModel()
        output.startAnimation.filter{$0 == true}.drive { [weak self] (done) in
            if done {
                self?.animationAfterPresenter(view: self!.splashView)
            }
        }.disposed(by: disposeBag)

        output.moveScreen.filter{$0 != .splashView}.drive { [weak self] (screen) in
            sleep(2)
            //TODO 로그인여부에 따라 mainView or loginView로 present
            let navController = UINavigationController()
            let loginViewController = self?.moveScreen(status: screen)
            navController.pushViewController(loginViewController!, animated: true)
            navController.modalPresentationStyle = .fullScreen
            self?.view.presentViewAnimationLeftToRight()
            self?.present(navController, animated: false, completion: nil)
            
        }.disposed(by: disposeBag)

    }
    
    
    private func animationAfterPresenter(view: SplashView){
        let commentArray = ["후기 검색","가격 비교","병원 선택","성형&시술"]
        let durationTime = 0.2
        
        let animationTimer = PublishSubject<Int>.timer(0, period: 0.4, scheduler: MainScheduler.instance).take((commentArray.count * 2) - 1)
        animationTimer.filter{$0 % 2 == 0 && $0/2 < commentArray.count-1}
            .map{
            view.secondTitleLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            view.secondTitleLabel.alpha = 0
                view.layoutIfNeeded()
                self.viewDidLayoutSubviews()
            return commentArray[$0/2]}
            .bind(animated: view.secondTitleLabel.rx.animated.animation(duration: durationTime, animations:{
                view.secondTitleLabel.alpha = 1
                view.secondTitleLabel.animate(duration: durationTime)
                view.layoutIfNeeded()
                self.viewDidLayoutSubviews()
            }).text).disposed(by: disposeBag)

        animationTimer.filter{$0 % 2 == 1 && $0/2 < commentArray.count-1}.map{commentArray[$0/2]}.bind(animated: view.secondTitleLabel.rx.animated.animation(duration: durationTime, animations: {

            UIView.animate(withDuration: durationTime) {
                view.secondTitleLabel.transform = CGAffineTransform(translationX: 0, y: view.secondTitleLabel.frame.maxY + (5 * view.frame.height / 812))
            }
            view.layoutIfNeeded()
            self.viewDidLayoutSubviews()

        }).text).disposed(by: disposeBag)


        animationTimer.filter{($0/2) == commentArray.count-1}.distinctUntilChanged()
            .map{
                view.secondTitleLabel.alpha = 0
                view.secondTitleLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                view.layoutIfNeeded()
                return commentArray[$0/2]}
            .bind(animated: view.secondTitleLabel.rx.animated.animation(duration: 0.5, animations: {
                UIView.animate(withDuration: 0.5) {
                    view.secondTitleLabel.animate(duration: 0.5)
                    view.secondTitleLabel.alpha = 1
                    view.layoutIfNeeded()
                } completion: { [weak self] (finished)  in
                    if finished{
                        //TODO 로그인여부에 따라 mainView or loginView로 present
                        self?.animationDone.on(.next(true))

                    }
                    
                }
            }).text).disposed(by: disposeBag)
        
        
    }
    
    
}

