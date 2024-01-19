//
//  ViewProtocol.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit

protocol ViewProtocol {
    func defalutUI()
    func defalutNavUI(title: String)
}

extension UIViewController: ViewProtocol {

    func defalutUI() {
        view.backgroundColor = .backgroundColor
    }
    
    func defalutNavUI(title: String) {
        navigationItem.title = title
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.labelColor,
            .font: UIFont.boldSystemFont(ofSize: 20) // 볼드 처리
        ]
        
        self.navigationController?.navigationBar.tintColor = .labelColor
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

