//
//  ProfileSelectViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit

class ProfileSelectViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var profileImageView: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        defalutNavUI(title: "프로필 설정")
        configureUI()
    }
    
    // 나중에 효율적인 방법으로 개선
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        for i in 0..<profileImageView.count {
            if profileImageView[i].tag == tag {
                UserDefaults.standard.set(tag, forKey: "profileImage")
    
                profileImageView[i].layer.borderWidth = 5
                profileImageView[i].layer.borderColor = UIColor.pointColor.cgColor
                
                mainImageView.image = ProfileImage.profileList[tag]
            } else {
                profileImageView[i].layer.borderWidth = 0
                profileImageView[i].layer.borderColor = .none
            }
        }
       
    }
    

}

extension ProfileSelectViewController {
    
    func configureUI() {
        
        mainImageView.layer.borderWidth = 5
        mainImageView.layer.borderColor = UIColor.pointColor.cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.backgroundColor = .systemGray5
        
        for i in 0..<profileImageView.count {
            profileImageView[i].image = ProfileImage.profileList[i]
            profileImageView[i].layer.cornerRadius = profileImageView[i].frame.width/2
            profileImageView[i].tag = i
            profileImageView[i].isUserInteractionEnabled = true
            profileImageView[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        }
    }
}
