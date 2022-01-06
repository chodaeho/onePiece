//
//  BountyInfo.swift
//  BountyList
//
//  Created by 조대호 on 2021/11/27.
//

import UIKit

// Model
// - 만약 코드가 길어 진다면 Model을 따로 파일을 만들었듯이 viewModel도 따로 만들면 됨
struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
//    이니셜라이저의 역할 (이니셜라이저의 대원칙)
//    - 스위프트는 에러에 대한 안전을 최우선시 한다.
//    - 빈 메모리에 접근하게 된다면 예기치 못한 에러가 발생할 수 있다.
//    - 타입 내부에 프로퍼티가 있다면 해당 프로퍼티에는 무조건 값이 있다는 것을 보장해야 한다.
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
