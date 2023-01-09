//
//  SelectButton.swift
//  Dabang
//
//  Created by seonggon on 2023/01/07.
//

import UIKit

/// 선택 토글 버튼 (백그라운드 컬러 변경)
final class SelectButton: UIButton {
    
    /// 선택 컬러
    @IBInspectable var selectColor: UIColor {
        get {
            return selectColor2
        }
        set {
            selectColor2 = newValue
        }
    }
    /// 기본 컬러
    @IBInspectable var deselectColor: UIColor {
        get {
            return deSelectColor2
        }
        set {
            deSelectColor2 = newValue
        }
    }
    
    private var selectColor2: UIColor = .clear
    private var deSelectColor2: UIColor = .clear
    
    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            backgroundColor = newValue ? selectColor2 : deSelectColor2
            super.isSelected = newValue
        }
    }
}
