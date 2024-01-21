//
//  SearchViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var sortBtns: [UIButton]!
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    var searchList: Search = Search(lastBuildDate: "", total: 0, start: 0, display: 0, items: []) {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    var start = 1
    var sort = "sim"
    var total = 0
    var naviTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defalutUI()
        configureUI()
        configureCollectionView()
        callRequest(text: naviTitle, sort: sort)
        selectedBtn(tag: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defalutNavUI(title: naviTitle)
        searchCollectionView.reloadData()
    }
    
    @IBAction func sortBtnClicked(_ sender: UIButton) {
        sort = "\(SearchBtn.allCases[sender.tag])"
        start = 1
        callRequest(text: naviTitle, sort: sort)
        selectedBtn(tag: sender.tag)
    }
    
}

extension SearchViewController {
    
    func selectedBtn(tag: Int) {
        for i in 0..<sortBtns.count {
            if sortBtns[i].tag == tag {
                sortBtns[i].backgroundColor = .white
                sortBtns[i].tintColor = .black
            } else {
                sortBtns[i].backgroundColor = .clear
                sortBtns[i].tintColor = .systemGray5
            }
        }
    }
    
    func configureUI() {
        totalLabel.textColor = .pointColor

        for i in 0..<sortBtns.count {
            designBtn(sortBtns[i], title: SearchBtn.allCases[i].rawValue, tag: i)
        }
    }
    
    func designBtn(_ btn: UIButton, title: String, tag: Int) {
        btn.setTitle("  \(title)  ", for: .normal)
        btn.tintColor = .systemGray5
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGray5.cgColor
        btn.tag = tag
    }
    
    func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        let cellhieght = ((UIScreen.main.bounds.width - (spacing * 3)) * 1.8) / 2.5
        
        layout.itemSize = CGSize(width: cellWidth, height: cellhieght)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        searchCollectionView.collectionViewLayout = layout
        
        let xib = UINib(nibName: SearchCollectionViewCell.identifier, bundle: nil)
        searchCollectionView.register(xib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    func callRequest(text: String, sort: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(start)&sort=\(sort)"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let data):
                if self.start == 1 {
                
                    self.searchList = data
                    self.totalLabel.text = "\(MyNumberFormatter.shared.string(for: data.total)!) 개의 검색 결과"
                    self.total = data.total
                    if self.total != 0 {
                        self.searchCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                } else {
                    self.searchList.items.append(contentsOf: data.items)
                }
                
                for i in 0..<self.searchList.items.count {
                    self.searchList.items[i].title = self.searchList.items[i].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                }
                
//                오류 : Cannot assign to property: 'item' is a 'let' constant
//                이건 왜 오류인가요..?
//                for item in self.searchList.items {
//                    item.title = ""
//                }
                
            case .failure(let failure):
                // 시간 남으면 검색 결과가 없을때 처리해주자
                print(failure)
            }
            
        }
        
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if searchList.items.count - 3 == item.row && searchList.items.count < total {
                start += 30
                callRequest(text: naviTitle, sort: sort)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        cell.configureCell(data: searchList.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: ProductViewController.identifier) as! ProductViewController
        
        vc.productData = searchList.items[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
