//
//  ReviewPagerViewController.swift
//  BasicMVVM
//
//  Created by 김동준 on 2021/01/08.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ReviewModelStateDelegate: class {
    func touchCompare(_ state: Bool)
    func selectedReview(_ state: PublishSubject<[Bool]>)
    func sendReviewInfo(_ arr: [ReviewInfo])
}

protocol CompareModelStateDelegate: class{
    func sendReviewInfo(_ arr: [ReviewInfo])
}

class ReviewPagerViewController: BaseViewController{
    
    weak var reviewDelegate: ReviewModelStateDelegate?
    weak var compareDelegate: CompareModelStateDelegate?
    private let selectedReview = PublishSubject<[Bool]>()
    
    lazy var pagerView = PagerView(frame: view.bounds)
    private let pageViewFactor = PageViewFactor()
    private let menuBarData = MenuCollection()
    
    lazy var vcArray: [UIViewController] = [self.VCInstance(name: .reviewViewController),self.VCInstance(name: .loginViewContrller)]
    private var direction: Int = 0
    private var viewIndex = PublishSubject<Int>()
    
    private var infoArr: [ReviewInfo] = []
    
    private var compareButton: UIButton = UIButton()
    private let disposeBag = DisposeBag()
    private var viewModel = ReviewViewModel()
    private lazy var input = ReviewViewModel
        .Input(viewDidLoaded: self.rx.viewDidAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
               compareGesture: compareButton.rx
                .tap
                .asObservable(),
               viewSelected: viewIndex.distinctUntilChanged(),
               selectedReviewArr: selectedReview.distinctUntilChanged()
               )
                                                    
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.lifeCycle?.drive{ [weak self] lifeCycle in
            guard let self = self else { return }
            
            switch lifeCycle{
            case .viewDidLoad:
                self.setNavigtionBar()
                self.view = self.pagerView
                self.setCollectionViewData()
                
                self.viewIndex.onNext(0)
                self.pagerView.menuTabBar.rx.itemSelected.distinctUntilChanged().map{$0.row}.bind { (seq) in
                    self.viewIndex.onNext(seq)
                }.disposed(by: self.disposeBag)
                
                for i in 0 ..< 4{
                    self.infoArr.append(ReviewInfo.setReviewInfo(seq: i))
                }
                
                
                
                DispatchQueue.main.async { [weak self] in
                    let firstIndexPath = IndexPath(item: 0, section: 0) // delegate 호출
                    self?.pagerView.menuTabBar.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
                    self?.menuBarData.collectionView(self!.pagerView.menuTabBar, didSelectItemAt: firstIndexPath)
                }
                
                
                break
            case .start:
                break
            }
            
        }.disposed(by: disposeBag)
        
        output.compareAvailable?.drive{ [weak self] available in
            guard let self = self else { return }
            if available{
                self.compareButton.isEnabled = true
                self.compareButton.setTitle("비교", for: .normal)
            }else{
                self.compareButton.isEnabled = false
                self.compareButton.setTitle("", for: .normal)
            }
        }.disposed(by: disposeBag)
    
        output.compareMode?.drive{ [weak self] compareMode in
            if compareMode{
                self?.compareButton.setTitle("완료", for: .normal)
            }else{
                self?.compareButton.setTitle("비교", for: .normal)
                
            }
            self?.reviewDelegate?.touchCompare(compareMode)
            self?.reviewDelegate?.selectedReview(self!.selectedReview)
        }.disposed(by: disposeBag)
    
        output.selectedNums?.filter{$0.count == 2}.drive{ [weak self] indexArr in
            //이걸 스코롤뷰를 해서 옮겨랏
            guard let self = self else { return }
            var compareDatas: [ReviewInfo] = []
            for i in 0 ..< self.infoArr.count{
                if i == indexArr[0] || i == indexArr[1] {
                    compareDatas.append(self.infoArr[i])
                }
            }
            self.compareDelegate!.sendReviewInfo(compareDatas)
            
            self.pagerView.menuTabBar.selectItem(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            self.pagerView.pager.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
            
        }.disposed(by: disposeBag)
        
    }
    
    
    private func VCInstance(name: VcId) -> UIViewController {
        switch name {
        case .reviewViewController:
            let reviewViewController = ReviewViewController()
            
            
            reviewDelegate = reviewViewController
            self.reviewDelegate!.sendReviewInfo(self.infoArr)
            return reviewViewController
        default:
            let compareViewController = CompareViewController()
            compareDelegate = compareViewController
            return compareViewController
            
        }
    }
    
    private func setNavigtionBar(){
        presentedViewController?.dismiss(animated: true, completion: nil)
        navigationController?.navigationBar.setColorWithView()
        tabBarController?.navigationItem.leftBarButtonItem = pageViewFactor.setNavigationBarIconView(frame: view.frame, compareButton: compareButton )
    }
    
    private func setCollectionViewData(){
        pagerView.menuTabBar.register(MenuCell.self, forCellWithReuseIdentifier: "menuCell")
        menuBarData.pager = pagerView.pager
        menuBarData.view = view
        menuBarData.highlightView = pagerView.highlightView
        pagerView.menuTabBar.delegate = menuBarData
        pagerView.menuTabBar.dataSource = menuBarData
        pagerView.menuTabBar.backgroundColor = .white
        
        pagerView.pager.register(PagerCell.self, forCellWithReuseIdentifier: "pagerCell")
        pagerView.pager.dataSource = self
        pagerView.pager.delegate = self
    }
    
}

extension ReviewPagerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let frameVC = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagerCell", for: indexPath) as! PagerCell
        var vc = vcArray[indexPath.row]
        vc.view.frame = frameVC
        cell.view = vc.view
        cell.awakeFromNib()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width), height: CGFloat(collectionView.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        if velocity.x < 0 { // -: 오른쪽에서 왼쪽 <<<
            direction = -1
            
        } else if velocity.x > 0 { // +: 왼쪽에서 오른쪽 >>>
            direction = 1
            
        } else { }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self!.pagerView.highlightView.transform = CGAffineTransform(translationX: scrollView.contentOffset.x / 2, y: 0)
            self!.pagerView.highlightView.layoutIfNeeded()
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.pointee.x / pagerView.menuTabBar.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        
        if direction > 0 { // >>>> 스와이프하면 스크롤은 중앙으로
            pagerView.menuTabBar.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        } else { // <<<< 스와이프하면 스크롤은 왼쪽으로
            pagerView.menuTabBar.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
        
        pagerView.menuTabBar.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        viewIndex.onNext(indexPath.row)

    }
    
    
}

enum VcId{
    case loginViewContrller
    case reviewViewController
}
