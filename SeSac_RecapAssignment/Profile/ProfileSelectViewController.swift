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
    
    var selectImageNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        defalutNavUI(title: "프로필 설정")
        configureUI()
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        ProfileImage.configureSelectedView(profileImageViews: profileImageView, mainImageView: mainImageView, userDefaultsKey: "profile", selectedImageViewTag: sender.view!.tag)
    }
    

}

extension ProfileSelectViewController {
    
    func configureUI() {
        
        ProfileImage.configureMainView(mainImageView, index: selectImageNumber)
        ProfileImage.configureViews(profileImageView, index: selectImageNumber)
        
        for i in 0..<profileImageView.count {
            profileImageView[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        }
    }
}
