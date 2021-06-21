//
//  LandmarkList.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = true
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
             (!showFavoritesOnly || landmark.isFavorite)
         }
     }
    
    var body: some View {
        NavigationView {
            List {
                
                Toggle(isOn: $showFavoritesOnly) {
                                  Text("Favorites only")
                              }
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
                  .navigationTitle("Landmarks")
              }
    }
}


struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        
//        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
//                  LandmarkList()
//                      .previewDevice(PreviewDevice(rawValue: deviceName))
//              }
        
        LandmarkList()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE (2nd generation)")
    }
}
