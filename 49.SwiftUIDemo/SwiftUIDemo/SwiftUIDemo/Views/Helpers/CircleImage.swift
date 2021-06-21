//
//  ImageView.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.white, lineWidth: 4))
          .shadow(radius: 7)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
