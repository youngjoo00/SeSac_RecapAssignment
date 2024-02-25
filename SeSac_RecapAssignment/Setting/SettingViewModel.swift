//
//  SettingViewModel.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/25/24.
//

import Foundation

class SettingViewModel {
    
    var numberOfsections: Int {
        Setting.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return Setting.allCases[section].settingCellData.count
    }
    
    func SettingTableViewCell(indexPath: IndexPath) -> String {
        return Setting.allCases[indexPath.section].settingCellData[indexPath.row]
    }
    
}
