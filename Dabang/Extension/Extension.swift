//
//  Extension.swift
//  Dabang
//
//  Created by seonggon on 2023/01/06.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}

extension String {
    /// 문자열  OO억  또는  OO억OO천  또는  OO만원  을 정수로 변환
    var priceToInt: Int {
        let components = self.components(separatedBy: ["억","천","만"])
        
        var price = 0
        
        if self.contains("만") {
            price = components.first?.toInt ?? 0
            return price * 10000
        }
        
        let hundredMillion = components.first?.toInt ?? 0
        price += hundredMillion * 100000000
        
        let thousand = components[safe: 1]?.toInt ?? 0
        price += thousand * 10000000
        
        return price
    }
    
    /// 문자열을 정수로 변환
    var toInt: Int {
        Int(self) ?? 0
    }
}
