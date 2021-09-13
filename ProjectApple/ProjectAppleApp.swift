//
//  ProjectAppleApp.swift
//  ProjectApple
//
//  Created by PAMA on 06/09/2021.
//

import SwiftUI

@main
struct ProjectAppleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
               
        }
    }
}
