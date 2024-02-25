//
//  ProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        defalutNavUI(title: "프로필 설정")
        
        mainView.imageNumber = UserDefaults.standard.integer(forKey: "profile")
    }
    
    @objc func completeBtnClicked(_ sender: UIButton) {
        
        if viewModel.outputValid.value {
            
            guard let nickname = mainView.nicknameTextField.text else { return }
            viewModel.saveUserDefaults(nickname: nickname, state: true)
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let tabBar = UITabBarController()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let firstTab = sb.instantiateViewController(withIdentifier: "MainNavigationController")

            let firstTabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
            firstTab.tabBarItem = firstTabBarItem

            let secondTab = UINavigationController(rootViewController: SettingViewController())
            let secondTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
            secondTab.tabBarItem = secondTabBarItem

            tabBar.viewControllers = [firstTab, secondTab]
            
            sceneDelegate?.window?.rootViewController = tabBar
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        
    }
    
    @objc func profileBtnClicked(_ sender: UIButton) {
        let vc = ProfileSelectViewController()
        
        vc.selectImageNumber = mainView.imageNumber
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileViewController {
    
    @objc func nicknameTextFieldChanged() {
        viewModel.inputNickname.value = mainView.nicknameTextField.text!
    }
    
}


// MARK: - UITextField
extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


// MARK: - UIGesture
extension ProfileViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return view.endEditing(true)
    }
}
