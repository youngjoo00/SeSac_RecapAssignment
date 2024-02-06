//
//  BaseViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/7/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defalutUI()
        self.navigationController?.navigationBar.tintColor = .labelColor
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    

}
