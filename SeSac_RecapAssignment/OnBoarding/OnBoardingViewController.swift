//
//  OnBoardingViewController.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit

class OnBoardingViewController: UIViewController {
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defalutUI()
        configureUI()
        
        startBtn.addTarget(self, action: #selector(startBtnClicked), for: .touchUpInside)
    }
    
    @objc func startBtnClicked() {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

extension OnBoardingViewController {
    
    func configureUI() {
        titleImageView.image = UIImage(named: "sesacShopping")
        startBtn.setTitle("시작하기", for: .normal)
        startBtn.setTitleColor(.labelColor, for: .normal)
        startBtn.backgroundColor = .pointColor
        startBtn.layer.cornerRadius = 8
        
        mainImageView.image = UIImage(named: "onboarding")
        mainImageView.contentMode = .scaleAspectFill
    }
}
