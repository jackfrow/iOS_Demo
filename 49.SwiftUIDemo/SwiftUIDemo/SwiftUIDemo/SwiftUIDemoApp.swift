//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    
    @StateObject private var modelData = ModelData()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
