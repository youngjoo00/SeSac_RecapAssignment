//
//  SettingProfileTableViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/21/24.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defalutUI()
    }

    func configureCell() {
        // 시간 남으면 configureImageView 함수로 통일시키면 좋을듯
        let image = UserDefaults.standard.integer(forKey: "profile")
        profileImageView.image = ProfileImage.profileList[image]
        profileImageView.layer.borderWidth = 5
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        }
        
        nicknameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
        nicknameLabel.textColor = .labelColor
        nicknameLabel.font = .boldSystemFont(ofSize: 20)
        
        
        let likeCount = UserDefaults.standard.integer(forKey: "likeCount")
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
