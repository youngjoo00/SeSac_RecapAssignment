//
//  Validation.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

enum Validation {
    
    static func textField(text: String) throws -> String {
        let regexPattern = #"^.{2,9}$"#
        guard text.range(of: regexPattern, options: .regularExpression) != nil else {
            print("2글자 이상 10글자 미만으로 설정해주세요")
            throw ValidationError.tooShortOrTooLong
        }
        
        let specialCharacterPattern = #"[@#$%]"#
        guard text.range(of: specialCharacterPattern, options: .regularExpression) == nil else {
            throw ValidationError.containsSpecialCharacters
        }
        
        let numberRegexPattern = #"[0-9]"#
        guard text.range(of: numberRegexPattern, options: .regularExpression) == nil else {
            print("닉네임에 숫자는 포함할 수 없어요")
            throw ValidationError.containsNumber
        }
        
        let whiteSpaceRegexPattern = #"\s"#
        guard text.range(of: whiteSpaceRegexPattern, options: .regularExpression) == nil else {
            print("닉네임에 공백은 포함할 수 없어요")
            throw ValidationError.containsWhitespace
        }
        
        return "사용할 수 있는 닉네임이에요"
    }

    static func completeBtnChecked(_ btn: UIButton, text: String) {
        if text == "사용할 수 있는 닉네임이에요" {
            btn.isEnabled = true
            btn.setTitleColor(.white, for: .normal)
        } else {
            btn.isEnabled = false
            btn.setTitleColor(.systemGray2, for: .normal)
        }
    }
}

enum ValidationError: String, Error {
    case tooShortOrTooLong = "2글자 이상 10글자 미만으로 설정해주세요"
    case containsSpecialCharacters = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
    case containsWhitespace = "닉네임에 공백은 포함할 수 없어요"
}
