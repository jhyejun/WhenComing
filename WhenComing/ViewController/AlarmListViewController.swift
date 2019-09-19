//
//  AlarmListViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmListViewController: HJViewController {
    // MARK: - UI Property
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        $0.backgroundColor = .blue
    }
    private let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 6
        $0.estimatedItemSize = CGSize(width: 160, height: 180)
    }
    private let alarmEmptyView: AlarmEmptyView = AlarmEmptyView()
    private let alarmDetailView: AlarmDetailView = AlarmDetailView()
    private var detailView: UIView {
        if rowCount == 0 {
            return alarmEmptyView
        } else {
            return alarmDetailView
        }
    }
    
    private var rowCount: Int {
        return 0
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - PrepareLayout
    override func prepareView() {
        super.prepareView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlarmEmptyCollectionViewCell.self, forCellWithReuseIdentifier: AlarmEmptyCollectionViewCell.reuseIdentifierName)
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.reuseIdentifierName)
        collectionView.setCollectionViewLayout(collectionLayout, animated: true)
        
        view.addSubviews([collectionView, detailView])
    }
    
    override func prepareConstraints() {
        super.prepareConstraints()
        
        if let navigationView = navigationView {
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(navigationView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.35)
            }
            
            detailView.snp.makeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        } else {
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.topMargin)
                make.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.35)
            }
            
            detailView.snp.makeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}

extension AlarmListViewController: UICollectionViewDelegate {
    
}

extension AlarmListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if rowCount == 0 {
            guard let cell: AlarmEmptyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmEmptyCollectionViewCell.reuseIdentifierName, for: indexPath) as? AlarmEmptyCollectionViewCell else {
                preconditionFailure("\(AlarmEmptyCollectionViewCell.className) optional binding failed")
            }
            return cell
        } else {
            guard let cell: AlarmCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.reuseIdentifierName, for: indexPath) as? AlarmCollectionViewCell else {
                preconditionFailure("\(AlarmCollectionViewCell.className) optional binding failed")
            }
            return cell
        }
    }
}
