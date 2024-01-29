//
//  UILabel+Extension.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit

extension UILabel {
    
    func configureLabel(text: String, textColor: UIColor, backgroundColor: UIColor, font: UIFont, textAlignment: NSTextAlignment) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
