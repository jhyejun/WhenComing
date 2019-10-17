//
//  AlarmSetViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 26/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlarmSetViewController: HJViewController {
    // MARK: - Constatnt
    struct Constant {
        // NavigationView
        static let backButtonImageName: String = "icon_back"
        static let deleteButtonImageName: String = "icon_delete"
        
        static let backButtonTopInset: CGFloat = 26
        static let backButtonLeadingOffset: CGFloat = 18
        static let backButtonBottomInset: CGFloat = 21
        static let deleteButtonTopInset: CGFloat = 24
        static let deleteButtonTrailingBottomInset: CGFloat = 20
    }
    
    // MARK: - Property
    private let dpBag: DisposeBag = DisposeBag()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - return NavigationView Method
    override func getNavigationView() -> UIView {
        return UIView(frame: .zero).then {
            let backButton: UIButton = UIButton(type: .custom)
            let deleteButton: UIButton = UIButton(type: .custom)

            backButton.setImage(UIImage(named: Constant.backButtonImageName), for: .normal)
            deleteButton.setImage(UIImage(named: Constant.deleteButtonImageName), for: .normal)
            
            backButton.sizeToFit()
            
            backButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: dpBag)
            deleteButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            }).disposed(by: dpBag)
            
            $0.addSubviews([backButton, deleteButton])
            
            backButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Constant.backButtonTopInset)
                make.leading.equalToSuperview().offset(Constant.backButtonLeadingOffset)
                make.bottom.equalToSuperview().inset(Constant.backButtonBottomInset)
            }
            
            deleteButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Constant.deleteButtonTopInset)
                make.trailing.bottom.equalToSuperview().inset(Constant.deleteButtonTrailingBottomInset)
            }
        }
    }
    
    // MARK: - PrepareLayout
    override func prepareView() {
        super.prepareView()
    }
    
    override func prepareConstraints() {
        super.prepareConstraints()
    }
}
