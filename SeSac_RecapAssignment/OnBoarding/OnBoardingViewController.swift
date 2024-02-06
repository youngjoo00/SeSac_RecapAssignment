//
//  OnBoardingViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit
import SnapKit
import Then

class OnBoardingViewController: UIViewController {
    
    let titleImageView = UIImageView()
    let mainImageView = UIImageView()
    let startBtn = PointColorButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        configureHierarchy()
        configureView()
        configureLayout()
        
        startBtn.addTarget(self, action: #selector(startBtnClicked), for: .touchUpInside)
    }
    
    @objc func startBtnClicked() {
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

extension OnBoardingViewController {
    
    func configureHierarchy() {
        
        [
            titleImageView,
            mainImageView,
            startBtn,
        ].forEach { view.addSubview($0) }
        
    }
    
    func configureView() {
        titleImageView.configureImageView(image: UIImage(named: "sesacShopping"), cornerRadius: 0)
        
        mainImageView.configureImageView(image: UIImage(named: "onboarding"), cornerRadius: 0)
        mainImageView.contentMode = .scaleAspectFill
        
        startBtn.setTitle("시작하기", for: .normal)
    }
    
    func configureLayout() {
        titleImageView.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.top).offset(-20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        startBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
}
