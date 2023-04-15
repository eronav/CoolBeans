//
//  CustomizeView.swift
//  CoolBeans
//
//  Created by Ronav Dholakia on 4/9/23.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    
    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History
    
    var dismiss: () -> Void
    
    @State private var size = 0
    @State private var isDecaf = false
    @State private var extraShots = 0
    @State private var milk = ConfigOption.none
    @State private var syrup = ConfigOption.none
    
    let sizeOptions = ["Small", "Medium", "Large"]
    
    var caffeine: Int {
        var caffeineAmount = drink.caffeine[size]
        caffeineAmount += extraShots * 60
        if (isDecaf) {
            caffeineAmount /= 20
        }
        return caffeineAmount
    }
    
    var calories: Int {
        var calorieAmount = drink.baseCalories
        calorieAmount += extraShots * 10
        if (drink.coffeeBased) {
            calorieAmount += milk.calories
        } else {
            calorieAmount += milk.calories / 8
        }
        calorieAmount += syrup.calories
        return calorieAmount * (size + 1)
    }
    
    var body: some View {
        Form {
            Section ("Basic Options") {
                Picker("Size", selection: $size) {
                    ForEach(sizeOptions.indices) { index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)
                
                if (drink.coffeeBased) {
                    Stepper("Extra Shots: \(extraShots)", value: $extraShots, in: 0...8)
                }
                
                Toggle("Decaffeinated", isOn: $isDecaf)
            }
            
            Section("Customizations") {
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                
                Picker("Syrup", selection: $syrup) {
                    ForEach(menu.syrupOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
            }
            
            Section("Estimates") {
                Text("**Caffeine:** \(caffeine)mg")
                Text("**Calories:** \(calories)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar {
            Button("Save") {
                history.add(drink: drink, size: sizeOptions[size], extraShots: extraShots, isDecaf: isDecaf, milk: milk, syrup: syrup, caffeine: caffeine, calories: calories)
                dismiss()
            }
        }
    }
}

//struct CustomizeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomizeView()
//    }
//}
