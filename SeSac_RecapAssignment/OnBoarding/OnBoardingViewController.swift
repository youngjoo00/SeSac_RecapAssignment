//
//  OnBoardingViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit
import SnapKit
import Then

class OnBoardingViewController: BaseViewController {
    
    let mainView = OnBoardingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.startBtn.addTarget(self, action: #selector(startBtnClicked), for: .touchUpInside)
    }
    
    @objc func startBtnClicked() {
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}
