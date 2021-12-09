//
//  CalendarView.swift
//  Intervallfasten
//
//  Created by Galic Dino on 09.12.21.
//

import SwiftUI

struct CalendarView: View {
    @State var date: Date = Date()
    
    @State var intervals: Array<(String, String)> = [
        ("12", "00"),
        ("00", "00")
    ]
    
    var body: some View {
        VStack {
            DatePicker("Datum", selection: $date)
            VStack {
                HStack {
                    HStack(spacing: 2) {
                        TextField("", text: $intervals[0].0).keyboardType(.numberPad).frame(width: 23.0)
                        Text(":")
                        TextField("", text: $intervals[0].1).keyboardType(.numberPad).frame(width: 23.0)
                    }
                    Text("Fasten")
                }
                HStack {
                    HStack(spacing: 2) {
                        TextField("", text: $intervals[1].0).keyboardType(.numberPad).frame(width: 23.0)
                        Text(":")
                        TextField("", text: $intervals[1].1).keyboardType(.numberPad).frame(width: 23.0)
                    }
                    Text("Essen")
                }
            }
            Button("Update") {
                
            }
        }.padding()
            .tabItem {
               Image(systemName: "calendar")
               Text("Kalender")
              }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

