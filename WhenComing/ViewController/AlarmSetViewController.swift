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
        
        // Setting StackView
        static let locationImageName: String = "icon_locationLb"
        static let stationImageName: String = "icon_stationLb"
        static let busImageName: String = "icon_busLb"
        
        static let descLabelTextSize: CGFloat = 13
        
        static let settingViewBorderWidth: CGFloat = 1
        static let settingViewCornerRadius: CGFloat = 3
        
        static let settingViewImageConstraint: CGFloat = 16
        static let settingViewLabelTopBottomTrailingConstraint: CGFloat = 16
        static let settingViewLabelLeadingConstraint: CGFloat = 11
        
        static let descLabelTextColor: UIColor = .rgb(128, 136, 155)
        static let settingViewBorderColor: UIColor = .rgb(223, 228, 254)
        static let settingViewLabelColor: UIColor = .rgb(69, 76, 97)
        static let settingViewLabelPlaceholderColor: UIColor = .rgb(196, 196, 196)
        
        static let labelText: String = "정류장 버스 설정"
        static let locationText: String = "서울"
        static let stationPlaceholderText: String = "정류장"
        static let busPlaceholderText: String = "버스"
    }
    
    // MARK: - UI Property
    private let busSettingStackView: UIStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 9
    }
    private let alarmMemoStackView: UIStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 9
    }
    
    // MARK: - Property
    private let dpBag: DisposeBag = DisposeBag()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme().defaultBackgroundColor
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
        
        setBusSettingStackView()
        
        view.addSubviews([busSettingStackView])
    }
    
    override func prepareConstraints() {
        super.prepareConstraints()
        
        if let navigationView = navigationView {
            busSettingStackView.snp.makeConstraints { make in
                make.top.equalTo(navigationView.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        } else {
            busSettingStackView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.topMargin).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
    
    func setBusSettingStackView() {
        let label: UILabel = UILabel().then {
            $0.font = $0.font.withSize(Constant.descLabelTextSize)
            $0.textColor = Constant.descLabelTextColor
            $0.text = Constant.labelText
        }
        
        let locationSettingView: UIView = UIView().then {
            $0.backgroundColor = .white
            $0.setCornerRadius(Constant.settingViewCornerRadius)
            $0.setBorder(color: Constant.settingViewBorderColor, width: Constant.settingViewBorderWidth)

            let iconImageView: UIImageView = UIImageView(image: UIImage(named: Constant.locationImageName))
            let textLabel: UILabel = UILabel().then {
                $0.text = Constant.locationText
                $0.textColor = Constant.settingViewLabelColor
            }
            
            $0.addSubviews([iconImageView, textLabel])
            
            iconImageView.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview().inset(Constant.settingViewImageConstraint)
            }
            textLabel.snp.makeConstraints { make in
                make.top.bottom.trailing.equalToSuperview().inset(Constant.settingViewLabelTopBottomTrailingConstraint)
                make.leading.equalTo(iconImageView.snp.trailing).offset(Constant.settingViewLabelLeadingConstraint)
            }
        }
        
        let locationTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedLocationSettingView(_:)))
        locationSettingView.addGestureRecognizer(locationTapGesture)
        
        let stationSettingView: UIView = UIView().then {
            $0.backgroundColor = .white
            $0.setCornerRadius(Constant.settingViewCornerRadius)
            $0.setBorder(color: Constant.settingViewBorderColor, width: Constant.settingViewBorderWidth)

            let iconImageView: UIImageView = UIImageView(image: UIImage(named: Constant.stationImageName))
            let textLabel: UILabel = UILabel().then {
                $0.text = Constant.stationPlaceholderText
                $0.textColor = Constant.settingViewLabelPlaceholderColor
            }
            
            $0.addSubviews([iconImageView, textLabel])
            
            iconImageView.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview().inset(Constant.settingViewImageConstraint)
            }
            textLabel.snp.makeConstraints { make in
                make.top.bottom.trailing.equalToSuperview().inset(Constant.settingViewLabelTopBottomTrailingConstraint)
                make.leading.equalTo(iconImageView.snp.trailing).offset(Constant.settingViewLabelLeadingConstraint)
            }
        }
        
        let stationTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedStationSettingView(_:)))
        stationSettingView.addGestureRecognizer(stationTapGesture)
        
        let busSettingView: UIView = UIView().then {
            $0.backgroundColor = .white
            $0.setCornerRadius(Constant.settingViewCornerRadius)
            $0.setBorder(color: Constant.settingViewBorderColor, width: Constant.settingViewBorderWidth)

            let iconImageView: UIImageView = UIImageView(image: UIImage(named: Constant.busImageName))
            let textLabel: UILabel = UILabel().then {
                $0.text = Constant.busPlaceholderText
                $0.textColor = Constant.settingViewLabelPlaceholderColor
            }
            
            $0.addSubviews([iconImageView, textLabel])
            
            iconImageView.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview().inset(Constant.settingViewImageConstraint)
            }
            textLabel.snp.makeConstraints { make in
                make.top.bottom.trailing.equalToSuperview().inset(Constant.settingViewLabelTopBottomTrailingConstraint)
                make.leading.equalTo(iconImageView.snp.trailing).offset(Constant.settingViewLabelLeadingConstraint)
            }
        }
        
        let busTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBusSettingView(_:)))
        busSettingView.addGestureRecognizer(busTapGesture)
        
        busSettingStackView.addArrangedSubview(label)
        busSettingStackView.addArrangedSubview(locationSettingView)
        busSettingStackView.addArrangedSubview(stationSettingView)
        busSettingStackView.addArrangedSubview(busSettingView)
    }
    
    @objc func tappedLocationSettingView(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func tappedStationSettingView(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func tappedBusSettingView(_ sender: UITapGestureRecognizer) {
        
    }
}
