//
//  ProfileSelectViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit
import SnapKit

class ProfileSelectViewController: UIViewController {
    
    let mainImageView = ProfileImageView(frame: .zero)
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var selectImageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defalutUI()
        defalutNavUI(title: "프로필 설정")
        
        configureHierarchy()
        configureView()
        configureLayout()
        
        // selectItem 으로 셀을 선택한다 (cell.isSelect 를 직접 true 지정하기 위함)
        profileCollectionView.selectItem(at: IndexPath(row: selectImageNumber, section: 0), animated: false, scrollPosition: .top)
    }
    
}

extension ProfileSelectViewController {
    
    func configureHierarchy() {
        
        [
            mainImageView,
            profileCollectionView,
        ].forEach { view.addSubview($0) }
    }
    
    func configureView() {
        mainImageView.isSelected = true
        mainImageView.image = ProfileImage.profileList[selectImageNumber]
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        profileCollectionView.backgroundColor = .clear
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        
        let cellWidth = UIScreen.main.bounds.width / 5
        let cellhieght = cellWidth
        
        layout.itemSize = CGSize(width: cellWidth, height: cellhieght)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(30)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImage.profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        
        cell.profileImageView.image = ProfileImage.profileList[indexPath.item]
        cell.profileImageView.isSelected = cell.isSelected
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // cellForItem 으로 선택한 셀을 찾을 수 있다.
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileCollectionViewCell
        
        cell.profileImageView.isSelected = cell.isSelected
        
        ProfileImage.updateSelectedImage(mainImageView: mainImageView, userDefaultsKey: "profile", selectedItem: indexPath.item)
        
    }
    
    // 이미 선택했던 셀이 있을 때 다른 셀을 선택하면 실행되는 함수
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileCollectionViewCell
        
        cell.profileImageView.isSelected = cell.isSelected
    }
}

@available(iOS 17.0, *)
#Preview {
    ProfileSelectViewController()
}
