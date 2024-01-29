//
//  UserInputTextField.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit
import SnapKit
class UserInputTextField: UITextField {
    
    let underLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(underLineView)
        configureView(placeholder: "")
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInputTextField {
    
    func configureView(placeholder: String) {
        textColor = .labelColor
        backgroundColor = .clear
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        underLineView.backgroundColor = .systemGray5
    }
    
    func configureLayout() {
        underLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
}
