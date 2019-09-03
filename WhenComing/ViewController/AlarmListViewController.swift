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
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        $0.backgroundColor = .blue
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.reuseIdentifierName)
        
        view.addSubViews([collectionView, detailView])
    }
    
    override func prepareConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.reuseIdentifierName, for: indexPath) as? AlarmCollectionViewCell else {
            preconditionFailure("\(AlarmCollectionViewCell.className) optional binding failed")
        }
        return cell
    }
}
