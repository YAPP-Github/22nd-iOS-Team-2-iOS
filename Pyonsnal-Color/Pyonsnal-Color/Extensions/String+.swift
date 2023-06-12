//
//  String+.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/11.
//

import UIKit

extension String {
    /// 취소선을 그어줍니다.
    ///  - Parameter color: 취소선 색
    func strikeThrough(with color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = NSMakeRange(0, attributedString.length)
        
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: range)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor,
                                      value: color,
                                      range: range)
        return attributedString
    }
    
}

extension NSMutableAttributedString {
    /// 특정 문자열의 color와 font 속성을 부여합니다.
    ///  - Parameter font: 적용할 font 속성 값
    ///  - Parameter color: 적용할 color 속성 값
    func appendAttributes(string: String, font: UIFont?,
                    color: UIColor?) {
        var attr: [NSAttributedString.Key: Any] = [:]
        attr[.font] = font
        attr[.foregroundColor] = color
        self.append(NSAttributedString(string: string, attributes: attr))
    }
}
