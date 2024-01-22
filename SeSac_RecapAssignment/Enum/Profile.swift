//
//  Profile.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

enum ProfileImage {
    
    static let profileList: [UIImage] = [UIImage(named: "profile1")!,
                               UIImage(named: "profile2")!,
                               UIImage(named: "profile3")!,
                               UIImage(named: "profile4")!,
                               UIImage(named: "profile5")!,
                               UIImage(named: "profile6")!,
                               UIImage(named: "profile7")!,
                               UIImage(named: "profile8")!,
                               UIImage(named: "profile9")!,
                               UIImage(named: "profile10")!,
                               UIImage(named: "profile11")!,
                               UIImage(named: "profile12")!,
                               UIImage(named: "profile13")!,
                               UIImage(named: "profile14")!
    ]
    
    static func configureViews(_ profileImages: [UIImageView], index: Int) {
        profileImages[index].layer.borderWidth = 5
        profileImages[index].layer.borderColor = UIColor.pointColor.cgColor
        
        for i in 0..<profileList.count {
            profileImages[i].image = profileList[i]
            profileImages[i].layer.cornerRadius = profileImages[i].frame.width/2
            profileImages[i].tag = i
            profileImages[i].isUserInteractionEnabled = true
        }
        
    }
    
    static func configureMainView(_ mainImageView: UIImageView, index: Int) {
        mainImageView.image = ProfileImage.profileList[index]
        mainImageView.layer.borderWidth = 5
        mainImageView.layer.borderColor = UIColor.pointColor.cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.backgroundColor = .systemGray5
    }
    
    static func configureSelectedView(profileImageViews: [UIImageView], mainImageView: UIImageView, userDefaultsKey: String, selectedImageViewTag: Int) {
        
        for imageView in profileImageViews {
            if imageView.tag == selectedImageViewTag {
                UserDefaults.standard.set(selectedImageViewTag, forKey: userDefaultsKey)

                imageView.layer.borderWidth = 5
                imageView.layer.borderColor = UIColor.pointColor.cgColor

                mainImageView.image = ProfileImage.profileList[selectedImageViewTag]
            } else {
                imageView.layer.borderWidth = 0
                imageView.layer.borderColor = .none
            }
        }
    }
    
    
    static var randomProfile: UIImage {
        get {
            return ProfileImage.profileList.randomElement()!
        }
    }
}
