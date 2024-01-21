//
//  SettingTableViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/21/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defalutUI()
        configureCell()
    }
    
    func configureCell() {
        titleLabel.textColor = .labelColor
    }
    
    
}
