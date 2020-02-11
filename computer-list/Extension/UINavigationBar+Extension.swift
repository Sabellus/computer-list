//
//  UINavigationBar+Extension.swift
//  computer-list
//
//  Created by Савелий Вепрев on 11.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit
extension UINavigationBar {
    func setupLarge() {
        if #available(iOS 11.0, *) {
            prefersLargeTitles = true
        }
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.shadowColor = .clear
            standardAppearance = appearance
            compactAppearance = appearance
            scrollEdgeAppearance = appearance
        }
    }
}
