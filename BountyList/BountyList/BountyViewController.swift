//
//  BountyViewController.swift
//  BountyList
//
//  Created by 조대호 on 2021/11/12.
//

//import UIKit
//
//class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    let nameList = ["brook","chopper","franky","luffy","nami","robin","sanji","zoro"]
//    let bountyList = ["33000000","50","44000000","3000000000","16000000","80000000","77000000","1200000000"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            let vc = segue.destination as? DetailViewController
//            if let index = sender as? Int {
//                vc?.name = nameList[index]
//                vc?.bounty = bountyList[index]
//            }
//        }
//    }
//
//    // UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return bountyList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
//            return UITableViewCell()
//        }
//
//        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
//        cell.imgView.image = img
//        cell.nameLabel.text = nameList[indexPath.row]
//        cell.bountyLable.text = "\(bountyList[indexPath.row])"
//
//        return cell
//    }
//
//    // UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("--> \(indexPath.row)")
//        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
//    }
//
//}
//
//class ListCell: UITableViewCell {
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var bountyLable: UILabel!
//}


// MVVM 디자인패턴으로 변경

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    MVVM 디자인 패턴으로 변경하기
    
//    Model
//    - BountyInfo
//    >BountyInfo 생성
    
//    View
//    - ListCell
//    > ListCell 필요한 정보를 ViewModel에서 받아야함
//    > ListClee은 ViewModel로 부터 받은 정보로 뷰 업데이트
    
//    ViewModel
//    - BountyViewModel
//    > BountyViewModel을 생성하고, 뷰레이어에서 필요한 메서드 만들기
//    > Model(BountyInfo)을 가지고 있어야 함.
    
    // MVVM 디자인 패턴의 ViewModel
    let viewModel = BountyViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
//                Model에 직접 접근하는게 아니라 ViewModel에 인덱스를 넘겨 필요한 데이터 요청
//                let bountyInfo = viewModel.bountyInfoList[index]
                let bountyInfo = viewModel.bountyInfo(at: index)
                
                vc?.viewModel.bountyInfo = bountyInfo
            }
        }
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
//        Model에 직접 접근하는게 아니라 ViewModel에 인덱스를 넘겨 필요한 데이터 요청
//        let bountyInfo = viewModel.bountyInfoList[indexPath.row]
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
//        MVVM 디자인패턴 ViewController가 실행을 안해도 되는 코드는 View 부분으로 옮김
//        let img = UIImage(named: "\(bountyInfo.name).jpg")
//        cell.imgView.image = img
//        cell.nameLabel.text = bountyInfo.name
//        cell.bountyLable.text = "\(bountyInfo.bounty)"
        
        
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
    
}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLable: UILabel!
    
//    MVVM 디자인 패턴의 View 생성
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLable.text = "\(info.bounty)"
    }
}

// MVVM 디자인 패턴의 ViewModel 생성
class BountyViewModel {
    // MVVM 디자인 패턴의 Model
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 3000000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 1200000000)
    ]
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted{ prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}
