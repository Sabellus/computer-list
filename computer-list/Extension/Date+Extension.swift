//
//  Date.swift
//  computer-list
//
//  Created by Савелий Вепрев on 11.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation
extension Date {
    func currentTimeSeconds() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}
