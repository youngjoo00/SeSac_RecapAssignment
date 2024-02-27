//
//  MainViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit
import Toast

final class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    @IBOutlet var shopSearchBar: UISearchBar!
    @IBOutlet var shopImageView: UIImageView!
    @IBOutlet var shopDescriptionLabel: UILabel!
    @IBOutlet var recentSearchLabel: UILabel!
    @IBOutlet var recentSearchAllDeleteBtn: UIButton!
    @IBOutlet var recentSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        defalutUI()
        configureUI()
        configureTableView()
        recentSearchAllDeleteBtn.addTarget(self, action: #selector(searchListAllDeleteBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //bindData()
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func deleteBtnClicked(_ sender: UIButton) {
        let btnPoint = sender.convert(CGPoint.zero, to: recentSearchTableView)
        if let indexPath = recentSearchTableView.indexPathForRow(at: btnPoint) {
            viewModel.inputDeleteButtonTapped.value = indexPath.row
        }
    }
    
    @objc func searchListAllDeleteBtn() {
        viewModel.inputSearchListAllDeleteTapped.value = ()
    }
}

extension MainViewController {
    
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputNickname.bind { value in
            self.defalutNavUI(title: "\(value)님의 새싹쇼핑")
        }
        
        viewModel.outputSearchList.bind { value in
            self.checkedSearchList()
            self.recentSearchTableView.reloadData()
        }
    }
    
    func configureUI() {
        shopSearchBar.searchBarStyle = .minimal
        shopSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        shopImageView.image = UIImage(named: "empty")
        
        shopDescriptionLabel.text = "최근 검색어가 없어요"
        shopDescriptionLabel.font = .boldSystemFont(ofSize: 18)
        shopDescriptionLabel.textColor = .labelColor
        
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.textColor = .labelColor
        recentSearchLabel.font = .boldSystemFont(ofSize: 16)
        
        recentSearchAllDeleteBtn.setTitle("모두 지우기", for: .normal)
        recentSearchAllDeleteBtn.setTitleColor(.pointColor, for: .normal)
        
        shopSearchBar.delegate = self
        shopSearchBar.barTintColor = UIColor.red
        shopSearchBar.searchTextField.backgroundColor = .darkGray
        shopSearchBar.searchTextField.textColor = .labelColor
        
    }
    
    func configureTableView() {
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        recentSearchTableView.delaysContentTouches = false
        recentSearchTableView.backgroundColor = .clear
        let xib = UINib(nibName: ResentSearchTableViewCell.identifier, bundle: nil)
        recentSearchTableView.register(xib, forCellReuseIdentifier: ResentSearchTableViewCell.identifier)
    }
    
    func checkedSearchList() {
        
        if viewModel.outputSearchList.value.isEmpty {
            recentSearchLabel.isHidden = true
            recentSearchAllDeleteBtn.isHidden = true
            recentSearchTableView.isHidden = true
            shopImageView.isHidden = false
            shopDescriptionLabel.isHidden = false
        } else {
            configureTableView()
            shopImageView.isHidden = true
            shopDescriptionLabel.isHidden = true
            recentSearchLabel.isHidden = false
            recentSearchAllDeleteBtn.isHidden = false
            recentSearchTableView.isHidden = false
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            var style = ToastStyle()
            style.backgroundColor = .pointColor
            style.messageColor = .labelColor
            self.view.makeToast("검색어를 입력해주세요!", duration: 2.0, position: .center, style: style)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController

            vc.naviTitle = searchBar.text!
            viewModel.inputSearchListData.value = searchBar.text
            viewModel.inputSearchBarSearchButtonTapped.value = searchBar.text
            view.endEditing(true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputSearchList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentSearchTableView.dequeueReusableCell(withIdentifier: ResentSearchTableViewCell.identifier, for: indexPath) as! ResentSearchTableViewCell
        
        cell.configureCell(text: viewModel.outputSearchList.value[indexPath.row], tag: indexPath.row)
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
        
        let title = viewModel.outputSearchList.value[indexPath.row]
        vc.naviTitle = title
        
        viewModel.inputDidSelectRowAt.value = indexPath.row
        
        view.endEditing(true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
