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

        configureUI()
        
        shopSearchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let nickname = UserDefaults.standard.string(forKey: "userNickname")!
        defalutNavUI(title: "\(nickname)님의 새싹쇼핑")
        print(UserDefaults.standard.integer(forKey: "likeCount"))
    }
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
        view.endEditing(true)
        navigationController?.pushViewController(vc, animated: true)
    }
}
