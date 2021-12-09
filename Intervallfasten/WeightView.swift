//
//  WeightView.swift
//  Intervallfasten
//
//  Created by Galic Dino on 09.12.21.
//

import SwiftUI

struct WeightView: View {
    var body: some View {
        ZStack(){
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
        }
        .tabItem {
           Image(systemName: "chart.pie")
           Text("Gewicht")
         }
        
    }
    
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView()
    }
}
