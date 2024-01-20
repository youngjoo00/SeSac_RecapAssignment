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
    
    var productTitle = ""
    var productID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        defalutNavUI(title: productTitle)
        configureWebView()
    }
}

extension ProductViewController {
    func configureWebView() {
        if let url = URL(string: "https://msearch.shopping.naver.com/product/\(productID)") {
            let request = URLRequest(url: url)
            productWebView.load(request)
        }
    }
}
