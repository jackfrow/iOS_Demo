//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        LandmarkList()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
