//
//  ProductViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/20/24.
//

import UIKit
import WebKit

class ProductViewController: UIViewController {

    @IBOutlet var productWebView: WKWebView!
    
    var productData: Item = Item(title: "", link: "", image: "", lprice: "", mallName: "", productID: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        defalutNavUI(title: productData.title)
        configureWebView()
        configureRightBarButton()
    }
}

extension ProductViewController {
    func configureWebView() {
        if let url = URL(string: "https://msearch.shopping.naver.com/product/\(productData.productID)") {
            let request = URLRequest(url: url)
            productWebView.load(request)
        }
    }
    
    func configureRightBarButton() {
        let button = UIBarButtonItem(image: LikeBtn.checkedLikeBtn(tag: Int(productData.productID)!), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        navigationItem.rightBarButtonItem = button
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func rightBarButtonItemClicked() {
        LikeBtn.clickedLikeBtn(key: Int(productData.productID)!)
        configureRightBarButton()
    }
}
