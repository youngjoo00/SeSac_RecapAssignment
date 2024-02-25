//
//  ProfileViewModel.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/24/24.
//

import Foundation

enum ValidationError: String, Error {
    case tooShortOrTooLong = "2글자 이상 10글자 미만으로 설정해주세요"
    case containsSpecialCharacters = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
    case containsWhitespace = "닉네임에 공백은 포함할 수 없어요"
}

class ProfileViewModel {
    
    var inputNickname = Observable(UserDefaults.standard.string(forKey: "userNickname") ?? "")
    
    var outputValidText = Observable("")
    var outputValid = Observable(false)
    
    init() {
        inputNickname.bind { value in
            self.validation(text: value)
        }
    }
    
    func saveUserDefaults(nickname: String, state: Bool) {
        UserDefaults.standard.set(nickname, forKey: "userNickname")
        UserDefaults.standard.set(state, forKey: "userState")
    }
    
    private func validation(text: String) {
        let regexPattern = #"^.{2,9}$"#
        guard text.range(of: regexPattern, options: .regularExpression) != nil else {
            print("2글자 이상 10글자 미만으로 설정해주세요")
            outputValidText.value = ValidationError.tooShortOrTooLong.rawValue
            outputValid.value = false
            return
        }
        
        let specialCharacterPattern = #"[@#$%]"#
        guard text.range(of: specialCharacterPattern, options: .regularExpression) == nil else {
            outputValidText.value = ValidationError.containsSpecialCharacters.rawValue
            outputValid.value = false
            return
        }
        
        let numberRegexPattern = #"[0-9]"#
        guard text.range(of: numberRegexPattern, options: .regularExpression) == nil else {
            print("닉네임에 숫자는 포함할 수 없어요")
            outputValidText.value = ValidationError.containsNumber.rawValue
            outputValid.value = false
            return
        }
        
        let whiteSpaceRegexPattern = #"\s"#
        guard text.range(of: whiteSpaceRegexPattern, options: .regularExpression) == nil else {
            print("닉네임에 공백은 포함할 수 없어요")
            outputValidText.value = ValidationError.containsWhitespace.rawValue
            outputValid.value = false
            return
        }
        
        outputValidText.value = "사용할 수 있는 닉네임이에요"
        outputValid.value = true
    }
}
