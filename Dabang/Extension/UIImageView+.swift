//
//  UIImageView+.swift
//  Dabang
//
//  Created by seonggon on 2023/01/08.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// 킹피셔 이미지 세팅
    /// - Parameter url: 이미지 URL 문자열
    func setKfImg(_ url: String) {
        let url = URL(string: url)
        kf.setImage(with: url)
    }
}
