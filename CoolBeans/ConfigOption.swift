//
//  ConfigOption.swift
//  CoolBeans
//
//  Created by Ronav Dholakia on 4/9/23.
//

import Foundation

struct ConfigOption: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let calories: Int
    
    static let none = ConfigOption(id: UUID(), name: "none", calories: 0)
}
