//
//  MainViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var shopSearchBar: UISearchBar!
    @IBOutlet var shopImageView: UIImageView!
    @IBOutlet var shopDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        defalutNavUI(title: "님의 새싹쇼핑")
        configureUI()
        
        shopSearchBar.delegate = self
    }

}

extension MainViewController {
    
    func configureUI() {
        shopSearchBar.searchBarStyle = .minimal
        shopSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"

        shopImageView.image = UIImage(named: "empty")
        
        shopDescriptionLabel.text = "최근 검색어가 없어요"
        shopDescriptionLabel.font = .boldSystemFont(ofSize: 18)
        shopDescriptionLabel.textColor = .labelColor
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
        
        vc.naviTitle = searchBar.text!
        navigationController?.pushViewController(vc, animated: true)
    }
}
