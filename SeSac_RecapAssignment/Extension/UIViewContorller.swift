//
//  UIAlert+Extension.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/23/24.
//

import UIKit

extension UIViewController {
    
    // 어떠한 함수든 일단 받아서 내보내려고 함수 () -> void 를 받아옴
    func showAlert(title: String, message: String, btnTitle: String, complectionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: btnTitle, style: .default) { _ in
            complectionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
