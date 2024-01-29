//
//  ProfileImageView.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit

// 1. 커스텀 뷰를 만들 클래스 생성
class ProfileImageView: UIImageView {
    
    var isSelected: Bool = false {
        didSet {
            layer.borderColor = isSelected ? UIColor.pointColor.cgColor : UIColor.clear.cgColor
        }
    }
    
    // 2. 코드베이스니까 init(frame:) 생성
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰의 레이아웃이 변경될 때마다 호출되므로, 뷰의 크기가 변경된 후에 cornerRadius 를 맥여야 올바르게 작동한다.
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}

extension ProfileImageView {
    func configureView() {
        layer.borderWidth = 5
        clipsToBounds = true
    }
}
