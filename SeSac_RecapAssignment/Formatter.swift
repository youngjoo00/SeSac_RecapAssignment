//
//  Formatter.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import Foundation
import Then
enum Formatter {
        
    static let numberFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal
    }
}
