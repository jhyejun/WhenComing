//
//  AlarmListViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmListViewController: HJViewController {
    private let collectionView: UICollectionView = UICollectionView(frame: .zero).then {
//        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection =
        $0.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.reuseIdentifierName)
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
