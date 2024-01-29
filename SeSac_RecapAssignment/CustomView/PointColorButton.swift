//
//  PointColorButton.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit

class PointColorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PointColorButton {
    func configureView() {
        setTitleColor(.labelColor, for: .normal)
        backgroundColor = .pointColor
        layer.cornerRadius = 8
        titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
}
