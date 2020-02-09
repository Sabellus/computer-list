//
//  List.swift
//  computer-list
//
//  Created by Савелий Вепрев on 02.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

struct List: Codable {
    
    var items: [Item]?
    var page: Int?
    var offset: Int?
    var total: Int?
    
    struct Item: Codable {
        let id: Int?
        let name: String?
        let company: Company?
        
        struct Company: Codable {
            let id: Int?
            let name: String?
        }
    }
    
}
