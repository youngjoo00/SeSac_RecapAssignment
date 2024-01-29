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
    
//    func configureHierarchy()
//    func configureView()
//    func configureConstraints()
}

protocol CellProtocol {
    func defalutUI()
}

extension UIViewController: ViewProtocol {

    func defalutUI() {
        view.backgroundColor = .backgroundColor
    }
    
    func defalutNavUI(title: String) {
        
        // 백버튼 처리
        self.navigationController?.navigationBar.tintColor = .labelColor
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // 백버튼을 처리하고 난 뒤에 타이틀을 설정해야 제대로 뷰가 그려진다.
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.labelColor,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        
    }
}

extension UITableViewCell: CellProtocol {
    func defalutUI() {
        backgroundColor = .darkGray
        selectionStyle = .none
    }
}
