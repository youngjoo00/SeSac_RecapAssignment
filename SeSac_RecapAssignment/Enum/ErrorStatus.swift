//
//  ErrorStatus.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/6/24.
//

import Foundation

enum ErrorStatus: String, Error {
    case failedRequest = "네트워크 통신 실패"
    case noData = "값이 없어요"
    case invalidResponse = "통신은 성공했지만, 응답값이 오지 않았어요"
    case invalidData = "통신은 성공했지만, 올바른 값이 오지 않았어요"
    case defalut = "알 수 없는 오류에요"
}
