//
//  DetailViewController.swift
//  BountyList
//
//  Created by 조대호 on 2021/11/21.
//
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAnimation()
    }
    
    private func prepareAnimation() {
//        view의 사이즈 만큼 벗어난 곳으로 배치
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
/*
//        스토리보드에 지정 해둔 가운데로 이동
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0

//        withDuration : 몇초동안에
//        delay : 몇초뒤에
//        usingSpringWithDamping : spring 효과
//        initialSpringVelocity : 초반 애니메이션 속도
//        animations: {self.view.layoutIfNeeded()} : View의 레이아웃을 즉시 업데이트
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
*/
  
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
//            CGAffineTransform은 변형을 가하는 것인데 원래 모습으로 되둘리기 위해선 .identity 사용
            self.nameLabel.transform = CGAffineTransform.identity
            
            // alpha를 1로 되돌림
            self.nameLabel.alpha = 1
        }, completion: nil)
        
//        nameLable과 bountyLabel의 delay를 나누기 위해 생성
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
//            CGAffineTransform은 변형을 가하는 것인데 원래 모습으로 되둘리기 위해선 .identity 사용
            self.bountyLabel.transform = CGAffineTransform.identity
            
            // alpha를 1로 되돌림
            self.bountyLabel.alpha = 1
        }, completion: nil)

//        이미지 플립
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
