
//
//  ScheduleView.swift
//  ProjectApple
//
//  Created by PAMA on 06/09/2021.
//

import SwiftUI
import WidgetKit


struct ScheduleView: View {
    @AppStorage("project", store: UserDefaults(suiteName: "group.wolskilukasz21.ProjectApple"))
    var projectData: Data = Data()

    @State private var date = Date()
   
    let coreDM: CoreDataManager
    @State private var products: [Product] = [Product]()
    @State private var schedules: [Schedule] = [Schedule]()
    @State private var calories:Double = 0
    @State private var carbohydrates:Double = 0
    @State private var proteins:Double = 0
    @State private var fats:Double = 0
    
    private func populateProducts(){
        products = coreDM.getAllProducts()
    }
    
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
            if let prod = sched.productRel?.allObjects as? [Product]{
                for produc in prod{
                    calories += (Double(produc.calories * (sched.weightFood / 100.0)))
                    carbohydrates += (Double(produc.carbohydrates * (sched.weightFood / 100.0)))
                    proteins  += (Double(produc.proteins * (sched.weightFood / 100.0)))
                    fats += (Double(produc.fats * (sched.weightFood / 100.0)))
                }
            }
        }
    
        let calendar = Calendar.current
        let dateSelect = calendar.startOfDay(for: date)
        let dateCurrent = calendar.startOfDay(for: Date())
        if (dateSelect == dateCurrent){
            
            let tmp: Dishes = Dishes(calories: calories, proteins: proteins, carbohydrates: carbohydrates, fats: fats)
            save(tmp)
            WidgetCenter.shared.reloadAllTimelines()
            
        }
        
    }
    
    func save(_ dishes: Dishes) {
        guard let projectData = try? JSONEncoder().encode(dishes) else { return }
        self.projectData = projectData
        
    }
    
    
    
    
    var body: some View {
        VStack{
            HStack{
                Button("-1 dzień"){
                    date.addTimeInterval(-24*60*60)
                    getDish()
                    calcMacro()
                }.padding()
                DatePicker("Wybierz date",
                           selection: $date,
                           displayedComponents: .date)
                    .padding()
                    .id(date)
                    .labelsHidden()
                    .onChange(of: date) {
                        [date] newDate in
                        getDish()
                        calcMacro()
                    }
                Button("+1 dzień"){
                    date.addTimeInterval(24*60*60)
                    getDish()
                    calcMacro()
                }.padding()
            }

            
            NavigationLink(destination: AddProductInDay(coreDM: coreDM, selectDate: date)) {
                Text("DODAJ PRODUKT")
                    .padding()
                    .background(LinearGradient(gradient: ColorApp.gradient, startPoint: .init(x: 0, y: 1), endPoint: .init(x: 1, y: 0)))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .font(Font.title2.bold())
                    .shadow(radius: 8)

            }
            
            Text("Kalorie: \(calories, specifier: "%.f") kcal")
            Text("Bialko: \(proteins, specifier: "%.f") g")
            Text("Tluszcze: \(fats, specifier: "%.f") g")
            Text("Weglowodany: \(carbohydrates, specifier: "%.f") g")
            
            List{
                
                ForEach(schedules, id: \.self) {
                    schedule in SimpleProductViewInSchedule(sched: schedule)
                        .listRowBackground(LinearGradient(gradient: ColorApp2.gradient, startPoint: .init(x: 1, y: 0), endPoint: .init(x: 0, y: 1)))
                    
                }.onDelete(perform: {indexSet in indexSet.forEach({
                    index in
                    let schedule = schedules[index]
                    coreDM.deleteDishes(schedule: schedule)
                    getDish()
                    calcMacro()
                })})
            }
            .navigationTitle("Posiłki")
            .onAppear(perform: {
                getDish()
                calcMacro()
                
            })
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(coreDM: CoreDataManager())
    }
}
