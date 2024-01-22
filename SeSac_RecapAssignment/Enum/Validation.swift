//
//  Validation.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

enum Validation {
    
    static func textField(text: String) -> String {
        let specialCharacter: [Character] = ["@", "#", "$", "%"]
        var result = ""
        
        let regexPattern = #"^[^@#$%0-9]{2,9}$"#
        if let _ = text.range(of: regexPattern, options: .regularExpression) {
            result = "사용할 수 있는 닉네임이에요"
        } else {
            result = "2글자 이상 10글자 미만으로 설정해주세요"
        }
        
        for item in specialCharacter {
            if let _ = text.firstIndex(of: item) {
                result = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            }
        }
        
        let numberRegexPattern = #"[0-9]"#
        if let _ = text.range(of: numberRegexPattern, options: .regularExpression) {
            result = "닉네임에 숫자는 포함할 수 없어요"
        }
        
        return result
    }

    static func completeBtnChecked(_ btn: UIButton, text: String) {
        if text == "사용할 수 있는 닉네임이에요" {
            btn.isEnabled = true
        } else {
            btn.isEnabled = false
        }
    }
}
