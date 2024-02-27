//
//  SettingViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit

class SettingViewController: UIViewController {

    let mainView = SettingView()
    let viewModel = SettingViewModel()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "설정")
        mainView.tableView.reloadData()
    }
}


extension SettingViewController {
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfsections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Setting.allCases[indexPath.section].rawValue == 0 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
            
            cell.configureView()

            return cell
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
            cell.titleLabel.text = viewModel.SettingTableViewCell(indexPath: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = Setting.allCases[indexPath.section].rawValue
        if section == 0 {
            // 프로필 변경 화면
            let vc = EditProfileViewController()
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if section == 1 && indexPath.row == Setting.allCases[indexPath.section].settingCellData.count-1 {

            showAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", btnTitle: "확인") {
                
                UserDefalutsManager.shared.removeAllUserDefalts()
                self.viewModel.inputRemoveAllSearchList.value = ()
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let OnBoarding = UINavigationController(rootViewController: OnBoardingViewController())
                
                sceneDelegate?.window?.rootViewController = OnBoarding
                sceneDelegate?.window?.makeKeyAndVisible()
            }
        }
        
    }
    
}
