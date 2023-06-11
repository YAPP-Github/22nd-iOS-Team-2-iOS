//
//  UIView+.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/11.
//

import UIKit

extension UIView {
    func makeRounded(with cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
