
//
//  ProductsView.swift
//  ProjectApple
//
//  Created by PAMA on 06/09/2021.
//

import SwiftUI

struct ProductsView: View {
    let coreDM: CoreDataManager
    @State private var products: [Product] = [Product]()
    
    private func populateProducts(){
        products = coreDM.getAllProducts()
    }
    
    var body: some View {
        VStack{
            
            NavigationLink(destination: AddProduct(coreDM: coreDM)) {
                Text("DODAJ PRODUKT")
                    .padding()
                    .background(LinearGradient(gradient: ColorApp.gradient, startPoint: .init(x: 0, y: 1), endPoint: .init(x: 1, y: 0)))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .font(Font.title2.bold())
                    .shadow(radius: 8)

            }
            .padding()

            List{
                ForEach(products, id: \.self) {
                    product in  SimpleProductView(name: product.name, calories: product.calories, carbohydrates: product.carbohydrates, fats: product.fats, proteins: product.proteins, addProdOnDay: false, coreDM: coreDM, product: product, dateMeal: Date(), mealWeight: "100")
                        .listRowBackground(LinearGradient(gradient: ColorApp2.gradient, startPoint: .init(x: 1, y: 0), endPoint: .init(x: 0, y: 1)))
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach {
                        index in
                        let product = products[index]
                        coreDM.deleteProduct(product: product)
                        populateProducts()
                    }
                })
            }
            .navigationTitle("Produkty")
            .onAppear(perform: {
                products = coreDM.getAllProducts()
            })
        }
       
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(coreDM: CoreDataManager())
        
    }
}
