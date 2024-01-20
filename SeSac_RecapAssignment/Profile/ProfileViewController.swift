//
//  ProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

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

    // navigationTitel 이 pop 될 경우 타이틀 글자가 사라짐,,
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "프로필 설정")
        
        imageNumber = UserDefaults.standard.integer(forKey: "profile")
    }
    
    @IBAction func changedTextField(_ sender: UITextField) {
        validationLabel.text = validationTextField(text: sender.text!)
        completeBtnChecked(text: validationLabel.text!)
    }
    
    @IBAction func didEndTextField(_ sender: UITextField) {
        validationLabel.text = validationTextField(text: sender.text!)
        completeBtnChecked(text: validationLabel.text!)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func returnKeyboardClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func completeBtnClicked(_ sender: UIButton) {
      
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userNickname")
        UserDefaults.standard.set(true, forKey: "userState")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tc = sb.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
        
        sceneDelegate?.window?.rootViewController = tc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @IBAction func profileBtnClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: ProfileSelectViewController.identifier) as! ProfileSelectViewController
        
        vc.selectImageNumber = imageNumber
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController {
    
    // 이것도 싱글톤처럼 따로 빼서 쓸 수 있을듯
    func validationTextField(text: String) -> String {
        let specialCharacter: [Character] = ["@", "#", "$", "%"]
        var result = ""
        
        // 효율적인 코드로 수정 필요
        let regexPattern = "^[^@#$%0-9]{2,9}$"
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
        UserDefaults.standard.set(Int.random(in: 0...13), forKey: "profile")
        profileImageView.image = ProfileImage.profileList[imageNumber]
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        
        cameraImageView.image = UIImage(named: "camera")
        
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
        // 버튼 텍스트 볼드 처리 나중에 해야함
        
        validationLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        
        nicknameLineView.backgroundColor = .lightGray
        
        profileBtn.setTitle("", for: .normal)
    }
    
}
