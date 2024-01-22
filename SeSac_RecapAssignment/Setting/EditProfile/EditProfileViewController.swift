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
        
        if let tempImage = UserDefaults.standard.string(forKey: "tempProfile") {
            imageNumber = Int(tempImage)!
        } else {
            imageNumber = UserDefaults.standard.integer(forKey: "profile")
        }
        
        Validation.completeBtnChecked(completeBtn, text: validationLabel.text!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "tempProfile")
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    @IBAction func completeBtnClicked(_ sender: UIButton) {
      
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userNickname")
        UserDefaults.standard.set(imageNumber, forKey: "profile")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileBtnClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(identifier: EditSelectProfileViewController.identifier) as! EditSelectProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EditProfileViewController {
    
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
        
        validationLabel.text = Validation.textField(text: nicknameTextField.text!)
        
        nicknameLineView.backgroundColor = .lightGray
        
        profileBtn.setTitle("", for: .normal)
    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
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
