//
//  EditProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var validationLabel: UILabel!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var nicknameLineView: UIView!
    @IBOutlet var profileBtn: UIButton!
    
    var imageNumber = UserDefaults.standard.integer(forKey: "profile") {
        didSet {
            profileImageView.image = ProfileImage.profileList[imageNumber]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "프로필 수정")
        
        imageNumber = UserDefaults.standard.integer(forKey: "profile")
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    @IBAction func completeBtnClicked(_ sender: UIButton) {
      
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userNickname")
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileBtnClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: ProfileSelectViewController.identifier) as! ProfileSelectViewController
        
        vc.selectImageNumber = imageNumber
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EditProfileViewController {
    
    // 이것도 싱글톤처럼 따로 빼서 쓸 수 있을듯
    func validationTextField(text: String) -> String {
        let specialCharacter: [Character] = ["@", "#", "$", "%"]
        var result = ""
        
        // 효율적인 코드로 수정 필요
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
    
    func completeBtnChecked(text: String) {
        if text == "사용할 수 있는 닉네임이에요" {
            completeBtn.isEnabled = true
        } else {
            completeBtn.isEnabled = false
        }
    }
    
    func configureUI() {
        profileImageView.image = ProfileImage.profileList[imageNumber]
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        
        cameraImageView.image = UIImage(named: "camera")
        
        nicknameTextField.delegate = self
        nicknameTextField.text = UserDefaults.standard.string(forKey: "userNickname")
        nicknameTextField.textColor = .labelColor
        nicknameTextField.backgroundColor = .clear
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        validationLabel.textColor = .pointColor
        validationLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.backgroundColor = .pointColor
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.tintColor = .labelColor
        completeBtn.layer.cornerRadius = 8
        completeBtn.isEnabled = false
        
        validationLabel.text = validationTextField(text: nicknameTextField.text!)
        
        nicknameLineView.backgroundColor = .lightGray
        
        profileBtn.setTitle("", for: .normal)
    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validationLabel.text = validationTextField(text: textField.text!)
        completeBtnChecked(text: validationLabel.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validationLabel.text = validationTextField(text: textField.text!)
        completeBtnChecked(text: validationLabel.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
