//
//  simpleProductView.swift
//  ProjectApple
//
//  Created by PAMA on 08/09/2021.
//

import SwiftUI


struct SimpleProductView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let name: String?
    let calories: Double
    let carbohydrates: Double
    let fats: Double
    let proteins: Double
    let addProdOnDay: Bool
    
    let coreDM: CoreDataManager
    let product: Product
    let dateMeal: Date
    let mealWeight: String
    @State private var showingAlert = false
    
    func backView() {
        self.presentationMode.wrappedValue.dismiss()
    }

    var body: some View{
            VStack(alignment: .center){
                    HStack{
                        Button(""){
                            if (mealWeight.trimmingCharacters(in: .whitespaces).isEmpty){
                                showingAlert = true
                            }
                            else{
                                coreDM.saveMeal(date: dateMeal, mealP: product, mealAmount: mealWeight)
                                backView()
                            }
                        }
                        .disabled(!addProdOnDay)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Nieprawidłowe dane"), message: Text("Pole musi być uzupełnione oraz nie może przekroczyć 10.000"), dismissButton: .default(Text("OK")))
                        }
                        Text("\(name ?? "Brak nazwy")")
                            .font(.title2.bold())
                    }
             
                    HStack(){
                       
                        Text("kcal: \n\(calories, specifier: "%.f")")
                            .padding()
                            .multilineTextAlignment(.center)

                        Text("B: \n\(proteins, specifier: "%.f")")
                            .padding()
                            .multilineTextAlignment(.center)
                     
                        Text("T:\n\(fats, specifier: "%.f")")
                            .padding()
                            .multilineTextAlignment(.center)
                       
                        Text("W: \n\(carbohydrates, specifier: "%.f")")
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
}


struct SimpleProductViewInSchedule: View{

    let sched: Schedule
    let dateFormater = DateFormatter()
    
    var body: some View{
        
            VStack(alignment: .center)
            {
                if let prod = sched.productRel?.allObjects as? [Product]
                {
                    ForEach(prod)
                    {
                        pr in
                        VStack
                        {
                                Text("\(pr.name ?? "")")
                                    .font(.title2.bold())
                                Text("\(sched.weightFood, specifier: "%.f") g/ml")
                                    .multilineTextAlignment(.center)
                                    .font(.title3)
                        }
                        HStack()
                        {
                          
                            Text("kcal: \n\(pr.calories * (sched.weightFood/100.0), specifier: "%.f")").padding()
                                .multilineTextAlignment(.center)
                            Text("B: \n\(pr.proteins * (sched.weightFood/100.0), specifier: "%.f")").padding()
                                .multilineTextAlignment(.center)
                            Text("T:\n\(pr.fats  * (sched.weightFood/100.0), specifier: "%.f")").padding()
                                .multilineTextAlignment(.center)
                            Text("W: \n\(pr.carbohydrates * (sched.weightFood/100.0), specifier: "%.f")").padding()
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
}
