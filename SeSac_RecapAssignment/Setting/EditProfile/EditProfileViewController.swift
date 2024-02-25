//
//  EditProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let mainView = EditProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defalutUI()
        
        mainView.nicknameTextField.delegate = self
        mainView.tapGestureRecognizer.delegate = self
        mainView.completeBtn.addTarget(self, action: #selector(completeBtnClicked), for: .touchUpInside)
        mainView.profileBtn.addTarget(self, action: #selector(profileBtnClicked), for: .touchUpInside)
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
        
        viewModel.outputValidText.bind { value in
            self.mainView.validationLabel.text = value
        }
        
        viewModel.outputValid.bind { value in
            self.mainView.validationLabel.textColor = value ? .pointColor : .red
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "프로필 수정")
        
        if let tempImage = UserDefaults.standard.string(forKey: "tempProfile") {
            mainView.imageNumber = Int(tempImage)!
        } else {
            mainView.imageNumber = UserDefaults.standard.integer(forKey: "profile")
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "tempProfile")
    }
    
    @objc func completeBtnClicked(_ sender: UIButton) {
        
        if viewModel.outputValid.value {
            UserDefaults.standard.set(mainView.nicknameTextField.text!, forKey: "userNickname")
            UserDefaults.standard.set(mainView.imageNumber, forKey: "profile")
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func profileBtnClicked(_ sender: UIButton) {
        let vc = EditSelectProfileViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EditProfileViewController {
    
    @objc func nicknameTextFieldChanged() {
        viewModel.inputNickname.value = mainView.nicknameTextField.text!
    }
}


extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension EditProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return view.endEditing(true)
    }
}
