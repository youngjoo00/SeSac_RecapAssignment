//
//  ResentSearchTableViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/22/24.
//

import UIKit

class ResentSearchTableViewCell: UITableViewCell {

    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
    }
    
    func configureUI() {
        backgroundColor = .black
//        selectionStyle = .none
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .labelColor
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .labelColor
        
        deleteBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteBtn.setTitle("", for: .normal)
        deleteBtn.tintColor = .systemGray5
    }
    
    func configureCell(text: String, tag: Int) {
        titleLabel.text = text
        
        deleteBtn.tag = tag
    }
}
