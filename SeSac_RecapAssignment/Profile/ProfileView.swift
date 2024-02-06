//
//  ProfileView.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/7/24.
//

import UIKit

class ProfileView: BaseView {
    
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
    
    override func configureHierarchy() {
        [
            profileBtn,
            profileImageView,
            cameraImageView,
            nicknameTextField,
            cameraImageView,
            validationLabel,
            completeBtn,
        ].forEach { addSubview($0) }
        
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
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
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.underLineView.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        completeBtn.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        UserDefaults.standard.set(Int.random(in: 0...13), forKey: "profile")
        
        profileImageView.image = ProfileImage.profileList[imageNumber]
        profileImageView.isSelected = true
        
        cameraImageView.image = UIImage(named: "camera")
        
        
        nicknameTextField.configureView(placeholder: "닉네임을 입력해주세요 :)")
        
        validationLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.isEnabled = false
        
        validationLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        
        
    }
}
