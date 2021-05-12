//
//  HomeViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/23.
//

import Foundation
import UIKit
import RxViewController
import RxSwift
import RxCocoa
//import RxGesture

class HomeViewController: BaseViewController{
    lazy var homeView: HomeView = HomeView(frame: view.bounds)
    private var timer : BehaviorRelay = BehaviorRelay(value: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setup() {
        super.setup()
        
    }
    
    var sliderData = ImageSliderCollection()
    var bfData = BeforeAfterCollection()
    var tagData = TagCollection()
    var bannerPagerData = BannerPagerCollection()
    
    private var disposeBag = DisposeBag()
    private var viewModel = HomeViewModel()
    private var beforeAfter: Bool = false
    private var baSelected = PublishSubject<Int>()
    private var infoArr: [BeforeAfterInfo] = []
    private lazy var input = HomeViewModel
        .Input(viewDidLoaded: self.rx.viewWillAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
               thumbGesture: homeView.slidableImage.thumb.rx
                .panGesture()
                .map{$0}
                .asObservable(),
               baSelectedInput: baSelected.distinctUntilChanged()
        )
    
    
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.lifeCycle?.drive{[weak self] lifeCycle in
            switch lifeCycle{
            case .viewDidLoad:
                self?.view.layoutIfNeeded()
                self?.presentedViewController?.dismiss(animated: true, completion: nil)
                self?.navigationController?.navigationBar.setColorWithView()
                self?.tabBarController?.navigationItem.leftBarButtonItem = self?.homeView.setNavigationBarIconView()
                
                self?.view = self?.homeView
                self?.homeView.imageSlider.register(ImageSliderCell.self, forCellWithReuseIdentifier: "imageSliderCell")
                self?.sliderData.slider_ = self!.homeView.imageSlider
                self?.homeView.imageSlider.dataSource = self?.sliderData
                self?.homeView.imageSlider.delegate = self?.sliderData
                //self?.sliderData.moveToNextPage(collectionView: self!.homeView.imageSlider, timer: true)
                
                
                self?.homeView.bACollection.register(BeforeAfterCell.self, forCellWithReuseIdentifier: "bfSliderCell")
                self?.homeView.bACollection.dataSource = self!.bfData
                self?.homeView.bACollection.delegate = self!.bfData
                
                self?.homeView.tagCollection.register(TagCell.self, forCellWithReuseIdentifier: "tagCell")
                self?.homeView.tagCollection.dataSource = self!.tagData
                self?.homeView.tagCollection.delegate = self!.tagData
                
                self?.homeView.bannerPagerCollection.register(BannerPagerCell.self, forCellWithReuseIdentifier: "BannerPagerCell")
                self?.bannerPagerData.bannerInfoArr_ = BannerInfo.setInfoAuto()
                self?.homeView.bannerPagerCollection.dataSource = self!.bannerPagerData
                self?.homeView.bannerPagerCollection.delegate = self!.bannerPagerData
                
                
                break
            case .start:
                break
            }
            
            
            }.disposed(by: disposeBag)
        
        output.sliderImageDriver?.filter{$0.count == 3}.drive{ [weak self] imageArr in
            self?.sliderData.imageArr_ = imageArr
            self?.homeView.imageSlider.reloadData()
            
            self?.homeView.imageSlider.selectItem(at: IndexPath(row: 5001, section: 0), animated: false, scrollPosition: .left)
            self?.sliderData.timerStart()
        }.disposed(by: disposeBag)
    
        output.beforeAfterViewSet?.filter{$0.count > 0}.drive{[weak self] infoArr in
            self?.homeView.slidableImage.image1 = infoArr[0].afterImage_
            self?.homeView.slidableImage.image2 = infoArr[0].beforeImage_
            self!.homeView.bACollection.contentSize.width = CGFloat(70 * infoArr.count)
            self?.infoArr = infoArr
            self?.bfData.imageArr_ = infoArr
            self?.bfData.baSelected_ = self!.baSelected
            self?.tagData.tagArr_ = self!.infoArr[0].tagString_
        }.disposed(by: disposeBag)
        
        output.beforeAfter?.filter{[weak self] beforeAfter in  beforeAfter != self!.beforeAfter}.drive{[weak self] state in
            self!.beforeAfter = state
            if state{
                self?.homeView.beforeLabel.textColor = .orange
                self?.homeView.afterLabel.textColor = .gray
            }else{
                self?.homeView.afterLabel.textColor = .orange
                self?.homeView.beforeLabel.textColor = .gray
            }
        }.disposed(by: disposeBag)
        
        output.baIndexSet?.filter{$0 > -1}.drive{[weak self] num in
            self?.homeView.slidableImage.image1 = self!.infoArr[num].afterImage_
            self?.homeView.slidableImage.image2 = self!.infoArr[num].beforeImage_
            self?.tagData.tagArr_ = self!.infoArr[num].tagString_
            self?.homeView.tagCollection.reloadData()
        }.disposed(by: disposeBag)
        
        
        
    }
    
    
}

