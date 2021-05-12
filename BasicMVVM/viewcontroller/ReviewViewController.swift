//
//  ReviewViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/23.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxViewController
import RxGesture

class ReviewViewController: BaseViewController{
    
    private var categoryReview: [ReviewInfo] = []
    public var categoryReview_: [ReviewInfo]{
        get{
            return categoryReview
        }set(val){
            categoryReview = val
        }
    }
    
    private var selectedReview: PublishSubject<[Bool]>!
    public var selectedReview_: PublishSubject<[Bool]>{
        get{
            return selectedReview
        }set(val){
            selectedReview = val
        }
    }
    
    lazy var reviewView: ReviewView = ReviewView(frame: view.bounds)
    private let categorySliderData = CategorySliderCollection()
    private let fDataMoel = FactitiousDataModel()
    
    private let reviewData = ReviewCollectionData()
    private let categoryTag = PublishSubject<String>()
    private var infoArr: [ReviewInfo] = []
    
    private let disposeBag = DisposeBag()
    private var viewModel = ReviewViewModel()
    private lazy var input = ReviewViewModel
        .Input(viewDidLoaded: self.rx.viewWillAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
               categoryString: categoryTag.distinctUntilChanged())
                                                    
    private lazy var output = viewModel.transform(input: input)
    
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.lifeCycle?.drive{ [weak self] lifeCycle in
            guard let self = self else { return }
            
            switch lifeCycle{
            case .viewDidLoad:
                self.view = self.reviewView
                
                self.reviewView.categorySlider.register(CategorySliderCell.self, forCellWithReuseIdentifier: "categorySliderCell")
                self.categorySliderData.categoryTag_ = self.categoryTag
                self.categorySliderData.categoryArr_ = self.fDataMoel.categoryArrData()
                
                
                self.reviewView.categorySlider.delegate = self.categorySliderData
                self.reviewView.categorySlider.dataSource = self.categorySliderData
                self.reviewView.categorySlider.bounces = false
                
//                for i in 0 ..< 4{
//                    self.infoArr.append(ReviewInfo.setReviewInfo(seq: i))
//                }
                
                //self.reviewData.reviewInfoArr_ = self.infoArr
                
                self.reviewView.reviewCollectionView.register(ReviewCell.self, forCellWithReuseIdentifier: "reviewCell")
                self.reviewView.reviewCollectionView.delegate = self.reviewData
                self.reviewView.reviewCollectionView.dataSource = self.reviewData
                
                
                
                break
            case .start:
                break
            }
            
        }.disposed(by: disposeBag)
        
        output.setCategoryData?.filter{$0 != ""}.drive{ [weak self] category in
            guard let self = self else { return }
            
            
            if self.infoArr.count != 0 {
                for e in self.infoArr{
                    
                    for factor in e.tagArr_{
                        
                        if factor == category{
                            self.categoryReview.append(e)
                            break
                        }
                    }

                }
                
                if category != "전체"{
                    self.reviewData.reviewInfoArr_ = self.categoryReview
                    self.reviewView.reviewCollectionView.reloadData()
                }else{
                    self.reviewData.reviewInfoArr_ = self.infoArr
                    self.reviewView.reviewCollectionView.reloadData()
                }
            }
        }.disposed(by: disposeBag)
        
    }
}

extension ReviewViewController: ReviewModelStateDelegate {
    func sendReviewInfo(_ arr: [ReviewInfo]) {
        infoArr = arr
        reviewData.reviewInfoArr_ = infoArr
        reviewView.reviewCollectionView.reloadData()
    }
    
    func selectedReview(_ state: PublishSubject<[Bool]>) {
        self.reviewData.selectedReview_ = state
    }
    
    func touchCompare(_ state: Bool) {
        self.reviewData.compareMode_ = state
        self.reviewView.reviewCollectionView.reloadData()
    }
    
}
