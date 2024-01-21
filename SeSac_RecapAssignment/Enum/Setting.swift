//
//  Enum.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/21/24.
//

import Foundation

enum Setting: Int, CaseIterable {
    case profile
    case setting
    
    var settingCellData: [String] {
        switch self {
        case .profile:
            return [""]
        case .setting:
            return ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]
        }
    }
    
}

