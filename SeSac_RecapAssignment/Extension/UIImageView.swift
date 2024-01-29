//
//  UIImageView+Extension.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/29/24.
//

import UIKit

extension UIImageView {
    
    func configureImageView(image: UIImage?, cornerRadius: CGFloat) {
        self.image = image
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
}
