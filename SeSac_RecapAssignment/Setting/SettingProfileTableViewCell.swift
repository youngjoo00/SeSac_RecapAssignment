//
//  SettingProfileTableViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/21/24.
//

import UIKit
import Then

class SettingProfileTableViewCell: BaseTableViewCell {

    let profileImageView = ProfileImageView(frame: .zero).then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 5
        $0.layer.borderColor = UIColor.pointColor.cgColor
    }
    
    let nicknameLabel = UILabel().then {
        $0.textColor = .labelColor
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let titleLabel = UILabel()

    override func configureHierarchy() {
        [
            profileImageView,
            nicknameLabel,
            titleLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.size.equalTo(80)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nicknameLabel)
        }
    }
    
    override func configureView() {
        let image = UserDefaults.standard.integer(forKey: "profile")
        profileImageView.image = ProfileImage.profileList[image]
        
        nicknameLabel.text = UserDefaults.standard.string(forKey: "userNickname")

        var likeCount = UserDefaults.standard.integer(forKey: "likeCount")
        let likeCountString = "\(likeCount)개의 상품"
        let otherString = "을 좋아하고 있어요!"
        let fullText = "\(likeCountString)\(otherString)"

        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.pointColor, range: (fullText as NSString).range(of: likeCountString))
        attributedString.addAttribute(.foregroundColor, value: UIColor.labelColor, range: (fullText as NSString).range(of: otherString))
        titleLabel.attributedText = attributedString
        titleLabel.font = .boldSystemFont(ofSize: 16)
    }
}
