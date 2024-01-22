//
//  SettingViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: "설정")
        settingTableView.reloadData()
    }
}


extension SettingViewController {
    func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = .clear

        let settingXib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(settingXib, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        let profileXib = UINib(nibName: SettingProfileTableViewCell.identifier, bundle: nil)
        settingTableView.register(profileXib, forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases[section].settingCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Setting.allCases[indexPath.section].rawValue == 0 {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
            
            cell.configureCell()
            return cell
        } else {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
            cell.titleLabel.text = Setting.allCases[indexPath.section].settingCellData[indexPath.row]
            
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
            let sb = UIStoryboard(name: "EditProfile", bundle: nil)
            let vc = sb.instantiateViewController(identifier: EditProfileViewController.identifier) as! EditProfileViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if section == 1 && indexPath.row == Setting.allCases[indexPath.section].settingCellData.count-1 {

            let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
            
            let cancelBtn = UIAlertAction(title: "취소", style: .cancel)
            let confirmBtn = UIAlertAction(title: "확인", style: .default) { _ in

                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                SearchList.list = []
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "OnBoarding", bundle: nil)
                let vc = sb.instantiateViewController(identifier: OnBoardingViewController.identifier) as! OnBoardingViewController
                
                let nav = UINavigationController(rootViewController: vc)
                
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }

            alert.addAction(cancelBtn)
            alert.addAction(confirmBtn)
            
            present(alert, animated: true)
        }
        
    }
    
}
