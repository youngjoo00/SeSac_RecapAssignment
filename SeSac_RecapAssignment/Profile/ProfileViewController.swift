//
//  ProfileViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let profileImageView = ProfileImageView(frame: .zero)
    let profileBtn = UIButton()
    let cameraImageView = UIImageView()
    let nicknameTextField = UserInputTextField()
    let validationLabel = PointColorLabel()
    let completeBtn = PointColorButton()
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    var imageNumber = UserDefaults.standard.integer(forKey: "profile") {
        didSet {
            profileImageView.image = ProfileImage.profileList[imageNumber]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defalutUI()
        configureHierarchy()
        configureView()
        configureLayout()
        
        completeBtn.addTarget(self, action: #selector(completeBtnClicked), for: .touchUpInside)
        
        profileBtn.addTarget(self, action: #selector(profileBtnClicked), for: .touchUpInside)

        Validation.completeBtnChecked(completeBtn, text: nicknameTextField.text!)
    }
    
    // navigationTitel 이 pop 될 경우 타이틀 글자가 사라짐,,
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "프로필 설정")
        
        imageNumber = UserDefaults.standard.integer(forKey: "profile")
    }
    
    @objc func completeBtnClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userNickname")
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
        
        vc.selectImageNumber = imageNumber
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController {
    
    func configureHierarchy() {
        [
            profileBtn,
            profileImageView,
            cameraImageView,
            nicknameTextField,
            cameraImageView,
            validationLabel,
            completeBtn,
        ].forEach { view.addSubview($0) }
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureView() {
        UserDefaults.standard.set(Int.random(in: 0...13), forKey: "profile")
        
        profileImageView.image = ProfileImage.profileList[imageNumber]
        profileImageView.isSelected = true
        
        cameraImageView.image = UIImage(named: "camera")
        
        nicknameTextField.delegate = self
        nicknameTextField.configureView(placeholder: "닉네임을 입력해주세요 :)")
        
        validationLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.isEnabled = false
        
        validationLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        
        tapGestureRecognizer.delegate = self
        
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
        
        profileBtn.snp.makeConstraints { make in
            make.edges.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView)
            make.trailing.equalTo(profileImageView)
            make.size.equalTo(30)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.underLineView.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        completeBtn.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        do {
            let result = try Validation.textField(text: text)
            validationLabel.text = result
        } catch {
            guard let error = error as? ValidationError else { return }
            validationLabel.text = error.rawValue
        }
        
        Validation.completeBtnChecked(completeBtn, text: validationLabel.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        do {
            let result = try Validation.textField(text: text)
            validationLabel.text = result
        } catch {
            guard let error = error as? ValidationError else { return }
            validationLabel.text = error.rawValue
        }
        
        Validation.completeBtnChecked(completeBtn, text: validationLabel.text!)
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
