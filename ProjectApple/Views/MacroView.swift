//
//  MacroView.swift
//  ProjectApple
//
//  Created by PAMA on 11/09/2021.
//

import SwiftUI

struct MacroView: View {
    let coreDM: CoreDataManager
  
    
    @State private var products: [Product] = [Product]()
    @State private var schedules: [Schedule] = [Schedule]()
    @State private var calories:Double = 0
    @State private var carbohydrates:Double = 0
    @State private var proteins:Double = 0
    @State private var fats:Double = 0
    @State private var date = Date()
    
    private func getDish(){
        calories = 0
        carbohydrates = 0
        proteins = 0
        fats = 0
        schedules = coreDM.getAllDishesOnDay(date: date)
    }
    

    
    func calcMacro(){
         
        calories = 0.0
        carbohydrates = 0.0
        proteins = 0.0
        fats = 0.0
        for sched in schedules{
            print(sched.weightFood)
            if let prod = sched.productRel?.allObjects as? [Product]{
                for produc in prod{
                    print("\(produc.calories) * \(sched.weightFood) / 100.0 = \(produc.calories * sched.weightFood / 100.0)")
                    calories += (Double(produc.calories * (sched.weightFood / 100.0)))
                    carbohydrates += (Double(produc.carbohydrates * (sched.weightFood / 100.0)))
                    proteins  += (Double(produc.proteins * (sched.weightFood / 100.0)))
                    fats += (Double(produc.fats * (sched.weightFood / 100.0)))
                }
            }
        }
    }
    
    var body: some View {
        VStack{            
            Text("kcal: \(calories, specifier: "%.f")")
            Text("Bialko: \(proteins, specifier: "%.f")")
            Text("Weglowodany: \(carbohydrates, specifier: "%.f")")
            Text("Tluszcze: \(fats, specifier: "%.f")")
        }
        .onAppear(perform: {
            //schedules = coreDM.getAllDishesOnDay(date: date)
            getDish()
            calcMacro()
            
        })
        
    }
}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        MacroView(coreDM: CoreDataManager())
    }
}
