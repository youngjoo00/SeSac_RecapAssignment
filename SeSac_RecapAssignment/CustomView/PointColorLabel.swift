//
//  PointColorLabel.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit

class PointColorLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PointColorLabel {
    
    func configureView() {
        textColor = .pointColor
    }
}
