//
//  ProfileCollectionViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    let profileImageView = ProfileImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileCollectionViewCell {
    
    func configureHierarchy() {
        [
            profileImageView
        ].forEach { addSubview($0) }
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
