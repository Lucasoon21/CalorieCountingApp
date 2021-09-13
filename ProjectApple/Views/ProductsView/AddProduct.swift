    //
    //  AddProduct.swift
    //  ProjectApple
    //
    //  Created by PAMA on 07/09/2021.
    //

    import SwiftUI
    import CoreData
    import Combine



    struct AddProduct: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        let coreDM: CoreDataManager
        
        @State private var productName:String = ""
        @State private var productCalories = ""
        @State private var productProteins = ""
        @State private var productCarbohydrates = ""
        @State private var productFats = ""
        @State private var showingAlert = false
        
        
        var body: some View {
            VStack{
                Form{
                    Text("Wartosci podawaj dla 100 ml / g danego produktu!")
                        .frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                        .multilineTextAlignment(.center)
                    
                    Section{
                        HStack{
                            Text("Nazwa").frame(width: 120, alignment: .leading)
                            TextField("Podaj nazwe", text:$productName)
                            
                        }
                        
                    }
                    Section{
                        HStack{
                            Text("Kalorie").frame(width: 120, alignment: .leading)
                            
                            TextField("Podaj ilość kalorii", text: $productCalories)
                                .keyboardType(.numberPad)
                                .onReceive(Just(productCalories)) {
                                    newValue in let filtered = newValue.filter {"0123456789".contains($0) }
                                    if filtered != newValue{
                                        self.productCalories = filtered
                                    }
                                }
                            
                        }
                    }
                    Section{
                        HStack{
                            Text("Bialko").frame(width: 120, alignment: .leading)
                            
                            TextField("Podaj ilość białka", text: $productProteins)
                                .keyboardType(.numberPad)
                                .onReceive(Just(productProteins)) {
                                    newValue in let filtered = newValue.filter {"0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.productProteins = filtered
                                    }
                                }
                        }
                    }
                    Section{
                        HStack{
                            Text("Tluszcze").frame(width: 120, alignment: .leading)
                            TextField("Podaj ilość tłuszczy", text: $productFats)
                                .keyboardType(.numberPad)
                                .onReceive(Just(productFats)) {
                                    newValue in let filtered = newValue.filter {"0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.productFats = filtered
                                    }
                                }
                            
                        }
                    }
                    Section{
                        HStack{
                            Text("Weglowodany").frame(width: 120, alignment: .leading)
                            
                            TextField("Podaj ilość węglowodanów", text: $productCarbohydrates)
                                .keyboardType(.numberPad)
                                .onReceive(Just(productCarbohydrates)) {
                                    newValue in let filtered = newValue.filter {"0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.productCarbohydrates = filtered
                                    }
                                }
                        }
                    }
                    Section{
                        Button("Dodaj produkt"){
                            if (productName.trimmingCharacters(in: .whitespaces).isEmpty || productFats.isEmpty || productCarbohydrates.isEmpty || productProteins.isEmpty || productCalories.isEmpty || productFats.count>4 || productCarbohydrates.count>4 || productProteins.count>4 || productCalories.count>4 ){
                                showingAlert = true
                            }
                            else{
                                
                                coreDM.saveProduct(name: productName, proteins: productProteins, fats: productFats, carbohydrates: productCarbohydrates, calories: productCalories)
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Nieprawidłowe dane"), message: Text("Wszystkie pola muszą być uzupełnione oraz wartości liczbowe nie mogą przekroczyć 10.000"), dismissButton: .default(Text("OK")))
                        }
                        
                    }
                }
            }
            .background(Color.yellow)
            .navigationTitle("Dodaj Produkt")
            
        }
        
        
    }

    struct AddProduct_Previews: PreviewProvider {
        static var previews: some View {
            AddProduct(coreDM: CoreDataManager())
        }
    }
