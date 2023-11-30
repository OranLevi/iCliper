//
//  SwiftData.swift
//  iCliper
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData

var sharedModelContainer: ModelContainer = {
    let schema = Schema([
        CopiedData.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

class SwiftDataManager {
    
    static let shared = SwiftDataManager()
    
    func addItem(context: ModelContext, text: String){
        let item = CopiedData(text: text)
        context.insert(item)
        save(context: context)
    }
    
    func deleteItem(context: ModelContext, item: CopiedData){
        context.delete(item)
        save(context: context)
    }
    
    func save(context: ModelContext){
        do {
            try context.save()
        } catch {
            print("# Error saving")
        }
    }
}
