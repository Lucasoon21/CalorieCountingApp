//
//  MacroWidget.swift
//  MacroWidget
//
//  Created by PAMA on 11/09/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider
{
    @AppStorage("project", store: UserDefaults(suiteName: "group.wolskilukasz21.ProjectApple"))
    var projectData: Data = Data()

    func placeholder(in context: Context) -> SimpleEntry
    {
        let totalMacro = Dishes(calories: 1456, proteins: 55, carbohydrates: 240, fats: 23)
        return SimpleEntry(date: Date(), totalMacro: totalMacro)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ())
    {
        guard let sched = try? JSONDecoder().decode(Dishes.self, from: projectData) else { return }
        let entry = SimpleEntry(date: Date(), totalMacro: sched)
        completion(entry)
    }
    
    
     func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ())
    {
        let currentDate:Date = Date()
        guard let sched = try? JSONDecoder().decode(Dishes.self, from: projectData) else { return }

        let entry = SimpleEntry(date: Date(), totalMacro: sched)
        
        let refreshDate = Calendar.current.date(byAdding: .second, value: 100, to: currentDate)!

        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
     }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalMacro: Dishes
}

struct MacroWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
   
    var body: some View {
        VStack{
            Text("Makroskładniki:")
                .padding(.bottom, 1)
            Text("Kcal: \(entry.totalMacro.calories, specifier: "%.f")")
            Text("B:  \(entry.totalMacro.proteins, specifier: "%.f") g")
            Text("T:  \(entry.totalMacro.fats, specifier: "%.f") g")
            Text("W:  \(entry.totalMacro.carbohydrates, specifier: "%.f") g")


        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
        .background(LinearGradient(gradient: WidgetApp.gradient, startPoint: .init(x: 0.15, y: 0.85), endPoint: .init(x: 0.85, y: 0.15)))
    }
}

@main
struct MacroWidget: Widget {
    let kind: String = "MacroWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MacroWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MacroWidget_Previews: PreviewProvider {
    static let totalMacro = Dishes(calories: 1200, proteins: 50, carbohydrates: 256, fats: 23)
    static var previews: some View {
        MacroWidgetEntryView(entry: SimpleEntry(date: Date(), totalMacro: totalMacro))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
          //  .ignoresSafeArea()
        MacroWidgetEntryView(entry: SimpleEntry(date: Date(), totalMacro: totalMacro))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            //.ignoresSafeArea()
    }
}


