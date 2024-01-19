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
    @IBOutlet var accuracyBtn: UIButton!
    @IBOutlet var dateBtn: UIButton!
    @IBOutlet var highPriceBtn: UIButton!
    @IBOutlet var lowPriceBtn: UIButton!
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
        
        print(naviTitle)
        defalutUI()
        configureUI()
        defalutNavUI(title: naviTitle)
        configureCollectionView()
        callRequest(text: naviTitle)
    }
    
}

extension SearchViewController {
    
    func configureUI() {
        totalLabel.textColor = .pointColor
        
        // 이게 맞나..?
        designBtn(accuracyBtn, title: "  정확도  ")
        designBtn(dateBtn, title: "  날짜순  ")
        designBtn(highPriceBtn, title: "  가격높은순  ")
        designBtn(lowPriceBtn, title: "  가격낮은순  ")
    }
    
    func designBtn(_ btn: UIButton, title: String) {
        btn.setTitle(title, for: .normal)
        btn.tintColor = .systemGray5
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    func callRequest(text: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(start)&sort=\(sort)"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                
                if self.start == 1 {
                    self.searchList = data
                    self.totalLabel.text = "\(MyNumberFormatter.shared.string(for: data.total)!) 개의 검색 결과"
                    self.total = data.total
                } else {
                    // 배열에 추가
                    self.searchList.items.append(contentsOf: data.items)
                    print(self.searchList.items)
                }
                
            case .failure(let failure):
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
                callRequest(text: naviTitle)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths)")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        cell.configureCell(data: searchList.items[indexPath.row])
        print(indexPath.row)
        return cell
    }
    
    
}
