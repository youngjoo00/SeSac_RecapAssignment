//
//  SettingTableViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/21/24.
//

import UIKit
import Then

class SettingTableViewCell: BaseTableViewCell {

    let titleLabel = UILabel().then {
        $0.textColor = .labelColor
    }
    
    override func configureHierarchy() {
        [
            titleLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        
    }
    
}
