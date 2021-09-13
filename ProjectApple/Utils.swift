//
//  Dishes.swift
//  ProjectApple
//
//  Created by PAMA on 12/09/2021.
//

import Foundation
import SwiftUI

struct Dishes: Codable {
    var calories: Double
    var proteins: Double
    var carbohydrates: Double
    var fats: Double
}

struct ColorApp {
    static let color0 = Color(red: 100/255, green: 221/255, blue: 0/255)
    static let color1 = Color(red: 30/255, green: 168/255, blue: 48/255)
    static let gradient = Gradient(colors: [color0, color1]);

}

struct ColorApp2 {
    static let color0 = Color(red: 133/255, green: 235/255, blue: 121/255)
           
    static let color1 = Color(red: 92/255, green: 195/255, blue: 81/255);

       static let gradient = Gradient(colors: [color0, color1]);
}


struct WidgetApp {
    static let color0 = Color(red: 100/255, green: 221/255, blue: 0/255)
           
    static let color1 = Color(red: 30/255, green: 168/255, blue: 48/255);
           

       static let gradient = Gradient(colors: [color0, color1]);
}

