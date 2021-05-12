//
//  ReviewViewModel.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/12/29.
//

import Foundation
import RxSwift
import RxCocoa

protocol ReviewDelegate {
    func touch(_ state: Bool)
}

final class ReviewViewModel: ViewModelType{
    private let disposeBag = DisposeBag()
    private var selectedView: ReviewViewId!
    
    private var isViewState: Bool = true
    
    func transform(input: Input) -> Output {
        let viewLifeCycle = BehaviorRelay(value: ViewLifeCycle.start)
        let selectedCategory = BehaviorRelay(value: "")
        let categoryData = BehaviorRelay(value: [CategoryInfo]())
        let compareAvailable = BehaviorRelay(value: false)
        let compareMode = BehaviorRelay(value: false)
        let selectedNums = BehaviorRelay(value: [Int]())
        var selectedIndex: [Bool] = []
        let compareResult = BehaviorRelay(value: [ReviewInfo]())
        
        input.viewSelected?.bind(onNext: { (seq) in
            switch seq{
            case 0:
                self.selectedView = .Review
                compareAvailable.accept(true)
                break
            case 1:
                self.selectedView = .Compare
                compareAvailable.accept(false)
                break
            default: 
                self.selectedView = .Compare
                compareAvailable.accept(false)
                break
            }
        }).disposed(by: disposeBag)
        
        input.viewDidLoaded?.subscribe{ [weak self] _ in
            viewLifeCycle.accept(.viewDidLoad)
            categoryData.accept((self?.setDefaultCategoryInfo())!)
        }.disposed(by: disposeBag)
        
        input.categoryString?.subscribe{ category in
            selectedCategory.accept(category)
        }.disposed(by: disposeBag)
        
        input.compareGesture?.subscribe{ _ in
            compareMode.accept(!(compareMode.value))
            if compareMode.value == false{
                var val: [Int] = []
                for i in 0 ..< selectedIndex.count{
                    if selectedIndex[i] {
                        val.append(i)
                    }
                }
                
                if val.count == 2{
                    selectedNums.accept(val)
                }
                
            }
            
        }.disposed(by: disposeBag)
    
        input.selectedReviewArr?.bind(onNext:{ arr in
            selectedIndex = arr
        }).disposed(by: disposeBag)
        
        input.originalReviewInfo?.bind(onNext: { (arr) in
            var info1 = arr[0]
            var info2 = arr[1]
            var val: [ReviewInfo] = []
            if Int(info1.price_) ?? 0  < Int(info2.price_) ?? 0{
                info1.priceColor_ = .Blue
                info2.priceColor_ = .Red
            }else{
                info1.priceColor_ = .Red
                info2.priceColor_ = .Blue
            }
            
            if Int(info1.heart_) ?? 0 < Int(info2.heart_) ?? 0{
                info1.heartColor_ = .Blue
                info2.heartColor_ = .Red
            }else{
                info2.heartColor_ = .Blue
                info1.heartColor_ = .Red
            }
            
            val.append(info1)
            val.append(info2)
            compareResult.accept(val)
        }).disposed(by: disposeBag)
        
        return Output(lifeCycle: viewLifeCycle.asDriver(),
                      setCategorySlider: categoryData.asDriver(),
                      setCategoryData: selectedCategory.asDriver(),
                      compareAvailable: compareAvailable.asDriver(),
                      compareMode: compareMode.asDriver(),
                      selectedNums: selectedNums.asDriver(),
                      comparedArr: compareResult.asDriver())
    }
    
    struct Input{
        var viewDidLoaded: Observable<Void>?
        var categoryString: Observable<String>?
        var compareGesture: Observable<Void>?
        var viewSelected: Observable<Int>?
        var selectedReviewArr: Observable<[Bool]>?
        var originalReviewInfo: Observable<[ReviewInfo]>?
    }
    
    struct Output{
        var lifeCycle: Driver<ViewLifeCycle>?
        var setCategorySlider: Driver<[CategoryInfo]>?
        var setCategoryData: Driver<String>?
        var compareAvailable: Driver<Bool>?
        var compareMode: Driver<Bool>?
        var selectedNums: Driver<[Int]>?
        var comparedArr: Driver<[ReviewInfo]>?
    }
    
    private func setDefaultCategoryInfo() -> [CategoryInfo]{
        var categoryArr: [CategoryInfo] = []
        
        for i in 0..<13 {
            let category = CategoryInfo()
            categoryArr.append(category)
        }
        
        //setting default data
        return categoryArr
    }
    
    
}


public enum ReviewViewId{
    case Review
    case Compare
}

public enum CompareColor{
    case Blue
    case Red
}
