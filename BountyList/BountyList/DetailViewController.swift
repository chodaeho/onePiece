//
//  DetailViewController.swift
//  BountyList
//
//  Created by 조대호 on 2021/11/21.
//
//
//import UIKit
//
//class DetailViewController: UIViewController {
//
//
//
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var bountyLabel: UILabel!
//
//    var name: String?
//    var bounty: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateUI()
//    }
//
//    func updateUI() {
//        if let name = self.name, let bounty = self.bounty {
//            let img = UIImage(named: "\(name).jpg")
//            imgView.image = img
//            nameLabel.text = name
//            bountyLabel.text = bounty
//        }
//    }
//
//    @IBAction func close(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//}

// MVVM 디자인패턴으로 변경

import UIKit

class DetailViewController: UIViewController {
    
//    MVVM 디자인 패턴으로 변경하기
    
//    Model
//    - BountyInfo
//    >BountyInfo 생성
    
//    View
//    - imgView, nameLable, bountyLable
//    > view들은 viewModel을 통해서 구성
    
//    ViewModel
//    - DetailViewModel
//    > 뷰레이어에서 필요한 메서드 만들기
//    > Model(BountyInfo)을 가지고 있어야 함.
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    var bountyInfo: BountyInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let bountyInfo = self.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
