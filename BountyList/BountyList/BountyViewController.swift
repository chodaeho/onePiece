//
//  BountyViewController.swift
//  BountyList
//
//  Created by 조대호 on 2021/11/12.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let viewModel = BountyViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                let bountyInfo = viewModel.bountyInfo(at: index)
                
                vc?.viewModel.bountyInfo = bountyInfo
            }
        }
    }
    
//    UICollectionViewDataSource
//    몇개를 보여줄지,
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
//    Cell을 어떻게 표현할지 정의
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else { return UICollectionViewCell() }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        
        cell.update(info: bountyInfo)
        
        return cell
    }
    
    //    UICollectionViewDelegate
    //    Cell 클릭 되었을때 어떻게 할지 정의
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
//    UICollectionViewDelegateFlowLayout
//    다양한 디바이스에 일관적으로 디자인을 보여주기 위해 Cell size 계산
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLable: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLable.text = "\(info.bounty)"
    }
    
}

class BountyViewModel {
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
