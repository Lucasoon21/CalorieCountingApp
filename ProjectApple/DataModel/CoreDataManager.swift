//
//  CoreDataManager.swift
//  ProjectApple
//
//  Created by PAMA on 07/09/2021.
//

import Foundation
import CoreData


class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error{
                fatalError("Core Data store failed \(error.localizedDescription)")
            }
        }
    }
    
    func deleteProduct(product: Product){
        persistentContainer.viewContext.delete(product)
        do {
            try persistentContainer.viewContext.save()
        } catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func getAllProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch{
            return []
        }
    }
    
    func saveProduct(name: String, proteins: String, fats: String, carbohydrates: String, calories: String) {
            let product = Product(context: persistentContainer.viewContext)
            product.calories = Double(calories) ?? 0
            product.carbohydrates = Double(carbohydrates) ?? 0
            product.fats = Double(fats) ?? 0
            product.proteins = Double(proteins) ?? 0
            product.name = name
            do{
                try persistentContainer.viewContext.save()
            } catch {
                print("Failed to save product! \(error)")
            }
        }


    func deleteDishes(schedule: Schedule){
        persistentContainer.viewContext.delete(schedule)
        do {
            try persistentContainer.viewContext.save()
        } catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    
    func saveMeal(date: Date, mealP: Product, mealAmount: String){
        let schedule = Schedule(context: persistentContainer.viewContext)
        
        let newDate = date.addingTimeInterval(2*60*60)
        schedule.dateEat = newDate
        schedule.addToProductRel(mealP)
        schedule.weightFood = Double(mealAmount)!
    
        do{
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save product! \(error)")
        }
        
    }
    
    func getAllDishesOnDay(date: Date) -> [Schedule] {

        let calendar = Calendar.current
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        
        var dateFrom = calendar.startOfDay(for: date)
        dateFrom.addTimeInterval(2*60*60)
        var dateTo = dateFrom
        dateTo.addTimeInterval(24*60*60)
        
        fetchRequest.predicate = NSPredicate(format: "(dateEat >= %@) AND (dateEat <  %@)",dateFrom as CVarArg, dateTo as CVarArg)
        let sort = NSSortDescriptor(keyPath: \Schedule.dateEat, ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch{
            return []
        }
        
    }

}


