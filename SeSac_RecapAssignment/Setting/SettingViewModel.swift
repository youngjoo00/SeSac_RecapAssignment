//
//  SettingViewModel.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/25/24.
//

import Foundation

class SettingViewModel {
    
    let inputRemoveAllSearchList: Observable<Void?> = Observable(nil)
    
    var numberOfsections: Int {
        Setting.allCases.count
    }
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputRemoveAllSearchList.bind { _ in
            UserDefaults.standard.removeObject(forKey: "searchList")
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return Setting.allCases[section].settingCellData.count
    }
    
    func SettingTableViewCell(indexPath: IndexPath) -> String {
        return Setting.allCases[indexPath.section].settingCellData[indexPath.row]
    }
    
}
