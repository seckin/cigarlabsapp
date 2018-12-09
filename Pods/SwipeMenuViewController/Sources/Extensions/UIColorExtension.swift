//
//  UIColorExtension.swift
//  SwipeMenuViewController
//
//  Created by 森下 侑亮 on 2017/08/15.
//  Copyright © 2017年 yysskk. All rights reserved.
//

import UIKit

extension UIColor {

    func convert(to color: UIColor, multiplier _multiplier: CGFloat) -> UIColor? {
        let multiplier = min(max(_multiplier, 0), 1)

        let components = cgColor.components ?? []
        let toComponents = color.cgColor.components ?? []

        if components.isEmpty || components.count < 3 || toComponents.isEmpty || toComponents.count < 3 {
            return nil
        }

//        let results = (0...3).map { (toComponents[$0] - components[$0]) * abs(multiplier) + components[$0] }
        let results0 = (toComponents[0] - components[0]) * abs(multiplier) + components[0]
        let results1 = (toComponents[1] - components[1]) * abs(multiplier) + components[1]
        let results2 = (toComponents[2] - components[2]) * abs(multiplier) + components[2]
        let results3 = (toComponents[3] - components[3]) * abs(multiplier) + components[3]
        return UIColor(red: results0, green: results1, blue: results2, alpha: results3)
    }
}
