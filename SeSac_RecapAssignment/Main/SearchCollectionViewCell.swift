//
//  SearchCollectionViewCell.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var mallNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    func configureUI() {
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 16
        
        likeBtn.tintColor = .black
        
        likeBackView.backgroundColor = .systemGray5
        likeBackView.layer.cornerRadius = likeBackView.frame.width/2
        
        mallNameLabel.font = .systemFont(ofSize: 13)
        mallNameLabel.textColor = .systemGray4
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .systemGray5
        titleLabel.numberOfLines = 2
        
        priceLabel.font = .boldSystemFont(ofSize: 17)
        priceLabel.textColor = .labelColor
    }
    
    func configureCell(data: Item) {
        let url = URL(string: "\(data.image)")
        productImageView.kf.setImage(with: url)
        productImageView.contentMode = .scaleAspectFill
        
        if UserDefaults.standard.bool(forKey: "\(data.productID)") {
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }

        mallNameLabel.text = data.mallName
        
//        data.title.components(separatedBy: "<b></b>")
        titleLabel.text = data.title
        
        priceLabel.text = MyNumberFormatter.shared.string(for: Int(data.lprice)) ?? "0"

    }
}
