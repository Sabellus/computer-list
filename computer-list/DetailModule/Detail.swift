//
//  Detail.swift
//  computer-list
//
//  Created by Савелий Вепрев on 03.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation


struct Detail: Codable {
    let id: Int32?
    var name: String?
    let imageUrl: String?
    let company: Company?
    let description: String?
    struct Company: Codable {
        let id: Int32?
        let name: String?
    }
}
