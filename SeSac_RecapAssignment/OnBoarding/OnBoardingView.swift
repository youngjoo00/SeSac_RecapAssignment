//
//  OnBoardingView.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/7/24.
//

import UIKit
import SnapKit
import Then

class OnBoardingView: BaseView {
    
    let titleImageView = UIImageView()
    let mainImageView = UIImageView()
    let startBtn = PointColorButton()
    
    override func configureHierarchy() {
        [
            titleImageView,
            mainImageView,
            startBtn,
        ].forEach { addSubview($0) }
        
    }
    
    override func configureLayout() {
        titleImageView.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.top).offset(-20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        
        startBtn.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        titleImageView.configureImageView(image: UIImage(named: "sesacShopping"), cornerRadius: 0)
        
        mainImageView.configureImageView(image: UIImage(named: "onboarding"), cornerRadius: 0)
        mainImageView.contentMode = .scaleAspectFill
        
        startBtn.setTitle("시작하기", for: .normal)
    }
}
