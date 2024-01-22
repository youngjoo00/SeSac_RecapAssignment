//
//  ProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit

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
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
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
    
    func configureUI() {
        UserDefaults.standard.set(Int.random(in: 0...13), forKey: "profile")
        profileImageView.image = ProfileImage.profileList[imageNumber]
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        
        cameraImageView.image = UIImage(named: "camera")
        
        nicknameTextField.delegate = self
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
        
        validationLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        
        nicknameLineView.backgroundColor = .lightGray
        
        profileBtn.setTitle("", for: .normal)
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validationLabel.text = Validation.textField(text: textField.text!)
        Validation.completeBtnChecked(completeBtn, text: validationLabel.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validationLabel.text = Validation.textField(text: textField.text!)
        Validation.completeBtnChecked(completeBtn, text: validationLabel.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
