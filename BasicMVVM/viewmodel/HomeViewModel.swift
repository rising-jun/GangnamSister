//
//  HomeViewModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType{
    let disposeBag = DisposeBag()
    private let networkModel: NetworkerModelable
    
    init(_ networkModel: NetworkerModelable = NetWorkModel()) {
        self.networkModel = networkModel
    }
    
    private var x: CGFloat = CGFloat(0.0)
    
    func transform(input: Input) -> Output {
        let viewLifeCycle = BehaviorRelay(value: ViewLifeCycle.start)
        let imageSliderArr = ImageURLInfo.init().imageSliderArr_
        var imageArr: [UIImage] = []
        let sliderImage = BehaviorRelay(value: [UIImage]())
        
        let beforeAfterDriver = BehaviorRelay(value: [BeforeAfterInfo]())
        let beforeAfter = BehaviorRelay(value: false)
        var xPosition: CGFloat = CGFloat(0.0)
        
        let baIndex = BehaviorRelay(value: -1)
        
        input.viewDidLoaded?.subscribe{ [weak self] _ in
            viewLifeCycle.accept(ViewLifeCycle.viewDidLoad)
            
            for i in 0 ..< imageSliderArr.count {
                let imageObservable = self?.networkModel.getHomeSliderImage(url: imageSliderArr[i])
                imageObservable?
                    .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
                    //.observeOn(MainScheduler.instance)
                    .bind(onNext: { (image) in
                        imageArr.append(image)
                        sliderImage.accept(imageArr)
                    }).disposed(by: self!.disposeBag)
            }
            
            var beforeAfterArr: [BeforeAfterInfo] = []
            for i in 0 ..< 2 {
                beforeAfterArr.append(BeforeAfterInfo.setInfoAuto(seq: i))
            }
            beforeAfterDriver.accept(beforeAfterArr)
            
        }.disposed(by: disposeBag)
        
        input.thumbGesture?.subscribe{ gesture in
            let trans = gesture.element!.translation(in: gesture.element?.view)
            switch gesture.element!.state {
            case .began, .changed:
                if (trans.x + xPosition < 0){
                    beforeAfter.accept(true)
                }else{
                    beforeAfter.accept(false)
                }
            case .ended, .cancelled:
                xPosition = trans.x + xPosition
            default: break
            }
            
        }.disposed(by: disposeBag)
        
        input.baSelectedInput?.subscribe{ num in
            baIndex.accept(num)
        }.disposed(by: disposeBag)
        
        return Output(lifeCycle: viewLifeCycle.asDriver(),
                      sliderImageDriver: sliderImage.asDriver(),
                      beforeAfterViewSet: beforeAfterDriver.asDriver(),
                      beforeAfter: beforeAfter.asDriver(),
                      baIndexSet: baIndex.asDriver())
    }
    
    struct Input{
        var viewDidLoaded: Observable<Void>?
        var thumbGesture: Observable<UIPanGestureRecognizer>?
        var baSelectedInput: Observable<Int>?
        
    }
    
    struct Output{
        var lifeCycle: Driver<ViewLifeCycle>?
        var sliderImageDriver: Driver<[UIImage]>?
        var beforeAfterViewSet: Driver<[BeforeAfterInfo]>?
        var beforeAfter: Driver<Bool>?
        var baIndexSet: Driver<Int>?
    }
}
