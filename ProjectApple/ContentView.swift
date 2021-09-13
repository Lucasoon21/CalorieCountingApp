
//
//  ContentView.swift
//  ProjectApple
//
//  Created by PAMA on 06/09/2021.
//

import SwiftUI


struct ContentView: View {
    let coreDM: CoreDataManager
           
    init(coreDM: CoreDataManager) {
        self.coreDM = coreDM
    }

    var body: some View {
        NavigationView {
            VStack(spacing:30){
                NavigationLink(destination: ProductsView(coreDM: coreDM)) {
                    Text("Przegladaj produkty")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: ColorApp.gradient, startPoint: .init(x: 0, y: 1), endPoint: .init(x: 1, y: 0)))
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .font(Font.title2.bold())
                        .shadow(radius: 8)

                }
                .padding()
                NavigationLink(destination: ScheduleView(coreDM: coreDM)) {
                    Text("Przegladaj dzisiejsze posilki")
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(LinearGradient(gradient: ColorApp.gradient, startPoint: .init(x: 0, y: 1), endPoint: .init(x: 1, y: 0)))
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .font(Font.title2.bold())
                        .shadow(radius: 8)

                }
                .padding()
             
            }
            .navigationBarTitle("Menu")
    }
        .background(Color(.red))
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

