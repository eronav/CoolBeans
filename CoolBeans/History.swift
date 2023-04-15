//
//  History.swift
//  CoolBeans
//
//  Created by Ronav Dholakia on 4/9/23.
//

import Foundation

class History: ObservableObject {
    @Published var servings: [Serving]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDrinks")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([Serving].self, from: data)
        } catch {
            servings = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("UNABLE TO SAVE DATA")
        }
    }
    
    func add(drink: Drink, size: String, extraShots: Int, isDecaf: Bool, milk: ConfigOption, syrup: ConfigOption, caffeine: Int, calories: Int) {
        var description = [String]()
        description.append(size)
        if (isDecaf) {
            description.append("decaffeinated")
        }
        switch (extraShots) {
            case 0:
                break
            case 1:
                description.append("1 extra shot")
                break;
            default:
                description.append("\(extraShots) extra shots")
        }
        if (milk != ConfigOption.none) {
            description.append("\(milk.name.lowercased()) milk")
        }
        if (syrup != ConfigOption.none) {
            description.append("\(syrup.name.lowercased()) syrup")
        }
        
        let descriptionString = description.joined(separator: ", ")
        let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, caffeine: caffeine, calories: calories)
        servings.insert(serving, at: 0)
        save()
    }
    
    func reorder(_ serving: Serving) {
        var copy = serving
        copy.id = UUID()
        servings.insert(copy, at: 0)
    }
    
    func delete(_ serving: Serving) {
        if let index = servings.firstIndex(of: serving) {
            servings.remove(at: index)
            save()
        }
    }
}
