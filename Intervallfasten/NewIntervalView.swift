//
//  NewIntervalView.swift
//  Intervallfasten
//
//  Created by Galic Dino on 09.12.21.
//

import SwiftUI

var interval: IntervalModel?

struct NewIntervalView: View {
    @State private var startInterval = Date()
    @State private var selectedType = Types._16_8
    @Binding var restartCounter: Bool
    
    var body: some View {
        VStack {
            Picker("Flavor", selection: $selectedType) {
                Text("16 8 Stunden").tag(Types._16_8)
                Text("1 1 Tage").tag(Types._1_1)
                Text("5 2 Tage").tag(Types._5_2)
                Text("TEST").tag(Types.test)
            }
            //DatePicker("Start: ", selection: $startInterval).padding()
            Button(action: {
                interval = IntervalModel(type: selectedType, startDate: startInterval)
                print("\(interval!.intervalTime), \(interval!.startDate)")
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(interval) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "interval")
                }
                
                restartCounter = true
                
                //UserDefaults.standard.set(interval, forKey: "interval")
                //var interval_ = UserDefaults.standard.object(forKey: "interval") as? (IntervalModel)
                //print("userdefaults: \(interval_!.intervalTime), \(interval_!.startDate)")
            }) {
                Text("Erstellen")
            }
        }
    }
}

struct NewIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        NewIntervalView(restartCounter: .constant(false))
    }
}

