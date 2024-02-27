//
//  Enum+SearchBtn.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/20/24.
//

import UIKit

enum SearchBtn: String, CaseIterable {
    case sim = "정확도"
    case date = "날짜순"
    case dsc = "가격높은순"
    case asc = "가격낮은순"
}

enum LikeBtn {
    static func checkedLikeBtn(tag productID: Int) -> UIImage? {
        if UserDefaults.standard.bool(forKey: "\(productID)") {
            return UIImage(systemName: "heart.fill")
        } else {
            return UIImage(systemName: "heart")
        }
    }
    
    static func clickedLikeBtn(key: Int) {
        if UserDefaults.standard.bool(forKey: "\(key)") {
            UserDefaults.standard.set(false, forKey: "\(key)")
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "likeCount")-1, forKey: "likeCount")
        } else {
            UserDefaults.standard.set(true, forKey: "\(key)")
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "likeCount")+1, forKey: "likeCount")
        }
    }
}
