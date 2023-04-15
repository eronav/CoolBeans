//
//  Menu.swift
//  CoolBeans
//
//  Created by Ronav Dholakia on 4/9/23.
//

import Foundation

class Menu: ObservableObject, Codable {
    let sections: [MenuSection]
    var milkOptions = [ConfigOption.none]
    var syrupOptions = [ConfigOption.none]
    
    init() {
        do {
            let url = Bundle.main.url(forResource: "menu", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let menuData = try JSONDecoder().decode(Menu.self, from: data)
            sections = menuData.sections
            milkOptions.append(contentsOf: menuData.milkOptions)
            syrupOptions.append(contentsOf: menuData.syrupOptions)
        } catch {
            fatalError("failed to load menu.json")
        }
    }
}
