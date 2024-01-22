//
//  EditSelectProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

class EditSelectProfileViewController: UIViewController {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var profileImageView: [UIImageView]!
    
    var selectImageNumber = UserDefaults.standard.integer(forKey: "profile")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tempImage = UserDefaults.standard.string(forKey: "tempProfile") {
            selectImageNumber = Int(tempImage)!
        } else {
            selectImageNumber = UserDefaults.standard.integer(forKey: "profile")
        }
        
        defalutUI()
        defalutNavUI(title: "프로필 설정")
        configureUI()
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        ProfileImage.configureSelectedView(profileImageViews: profileImageView, mainImageView: mainImageView, userDefaultsKey: "tempProfile", selectedImageViewTag: sender.view!.tag)
    }
    
}

extension EditSelectProfileViewController {
    
    func configureUI() {
        
        ProfileImage.configureMainView(mainImageView, index: selectImageNumber)
        ProfileImage.configureViews(profileImageView, index: selectImageNumber)
        
        for i in 0..<profileImageView.count {
            profileImageView[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        }
    }
    
}
