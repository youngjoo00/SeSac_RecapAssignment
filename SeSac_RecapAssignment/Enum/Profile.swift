//
//  Profile.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

enum ProfileImage {
    
    static let profileList: [UIImage] = [
        UIImage(named: "profile1")!,
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
    
    static func updateSelectedImage(mainImageView: UIImageView, userDefaultsKey: String, selectedItem: Int) {
        mainImageView.image = ProfileImage.profileList[selectedItem]
        UserDefaults.standard.set(selectedItem, forKey: userDefaultsKey)
    }
    
    
    static var randomProfile: UIImage {
        get {
            return ProfileImage.profileList.randomElement()!
        }
    }
}
