//
//  Formatter.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import Foundation

class MyNumberFormatter {
    
    private init() {}
    
    // 클로저를 선언하고, 즉시 실행함으로써 변수에 formatter 라는 값을 리턴
    static let shared: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
