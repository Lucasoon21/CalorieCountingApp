//
//  AddProductInDay.swift
//  ProjectApple
//
//  Created by PAMA on 08/09/2021.
//

import SwiftUI
import Combine

struct AddProductInDay: View {
    
    let coreDM: CoreDataManager
    let selectDate: Date
    
    @State private var mealWeight = "100"
    @State private var products: [Product] = [Product]()
    
    var body: some View {
        VStack{
            Form{
                Section{
                    HStack{
                        Text("g/ml produktu: ").frame(width: 120, alignment: .leading)
                        
                        TextField("Podaj wagę/pojemność produktu", text: $mealWeight)
                            .keyboardType(.numberPad)
                            .onReceive(Just(mealWeight)) {
                                newValue in let filtered = newValue.filter {"0123456789".contains($0) }
                                if filtered != newValue {
                                    self.mealWeight = filtered
                                }
                            }
                    }
                }
                
                Section{
                    List{
                        ForEach(products, id: \.self) {
                            product in  SimpleProductView(name: product.name, calories: product.calories, carbohydrates: product.carbohydrates, fats: product.fats, proteins: product.proteins, addProdOnDay: true, coreDM: coreDM, product: product, dateMeal: selectDate, mealWeight: mealWeight)
                                .listRowBackground(LinearGradient(gradient: ColorApp2.gradient, startPoint: .init(x: 1, y: 0), endPoint: .init(x: 0, y: 1)))
                        }
                    }
                }
            }
        
            .navigationTitle("Produkty")
            .onAppear(perform: {
                products = coreDM.getAllProducts()
            })
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct AddProductInDay_Previews: PreviewProvider {
    static var previews: some View {
        AddProductInDay(coreDM: CoreDataManager(), selectDate: Date())
    }
}
