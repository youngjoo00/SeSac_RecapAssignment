//
//  ProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nicknameTextField.delegate = self
        mainView.tapGestureRecognizer.delegate = self
        
        mainView.completeBtn.addTarget(self, action: #selector(completeBtnClicked), for: .touchUpInside)
        mainView.profileBtn.addTarget(self, action: #selector(profileBtnClicked), for: .touchUpInside)

        Validation.completeBtnChecked(mainView.completeBtn, text: mainView.nicknameTextField.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "프로필 설정")
        
        mainView.imageNumber = UserDefaults.standard.integer(forKey: "profile")
    }
    
    @objc func completeBtnClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(mainView.nicknameTextField.text!, forKey: "userNickname")
        UserDefaults.standard.set(true, forKey: "userState")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tc = sb.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
        
        sceneDelegate?.window?.rootViewController = tc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc func profileBtnClicked(_ sender: UIButton) {
        let vc = ProfileSelectViewController()
        
        vc.selectImageNumber = mainView.imageNumber
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        do {
            let result = try Validation.textField(text: text)
            mainView.validationLabel.text = result
        } catch {
            guard let error = error as? ValidationError else { return }
            mainView.validationLabel.text = error.rawValue
        }
        
        Validation.completeBtnChecked(mainView.completeBtn, text: mainView.validationLabel.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        do {
            let result = try Validation.textField(text: text)
            mainView.validationLabel.text = result
        } catch {
            guard let error = error as? ValidationError else { return }
            mainView.validationLabel.text = error.rawValue
        }
        
        Validation.completeBtnChecked(mainView.completeBtn, text: mainView.validationLabel.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return view.endEditing(true)
    }
}
