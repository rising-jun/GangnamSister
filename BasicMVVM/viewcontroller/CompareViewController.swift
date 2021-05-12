//
//  CompareViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/02/05.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxViewController

class CompareViewController: BaseViewController{
    
    lazy var compareView = CompareView(frame: view.frame)
    
    private let disposeBag = DisposeBag()
    
    
    private var reviewInfoArr = PublishSubject<[ReviewInfo]>()
    
    private let viewModel = ReviewViewModel()
    private lazy var input = ReviewViewModel
        .Input(viewDidLoaded: self.rx.viewDidAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
            originalReviewInfo: reviewInfoArr.filter{$0.count == 2}.asObservable()
        )
    private lazy var output = viewModel.transform(input: input)
    
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.lifeCycle?.drive{ [weak self] lifeCycle in
            guard let self = self else { return }
            switch lifeCycle{
            case .viewDidLoad:
                self.view = self.compareView
                
                break
            case .start:
                break
            }
            
        }.disposed(by: disposeBag)
        
        output.comparedArr?.filter{$0.count == 2}.drive{ [weak self] arr in
            guard let self = self else { return }
            print("\(arr[0].priceColor_) \(arr[0].heartColor_)")
            self.compareView.setfirstInfoUI(reviewInfo: arr[0])
            self.compareView.setSecondInfoUI(reviewInfo: arr[1])
        }.disposed(by: disposeBag)
        
        
    }
}
extension CompareViewController: CompareModelStateDelegate{
    func sendReviewInfo(_ arr: [ReviewInfo]) {
        compareView.setup()
        //TODO 두개의 정보데이터가 오면 뷰모델로 보내 각각의 객체로 받기(가격비교, 하트비교)
        reviewInfoArr.on(.next(arr))
        
        
    }
    
}
