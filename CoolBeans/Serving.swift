//
//  Serving.swift
//  CoolBeans
//
//  Created by Ronav Dholakia on 4/9/23.
//

import Foundation

struct Serving: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
