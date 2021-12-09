//
//  ContentView.swift
//  Intervallfasten
//
//  Created by Galic Dino on 14.10.21.
//

import SwiftUI

struct ContentView: View {
    @State var toDate = Calendar.current.date(byAdding: .second, value: 0, to: Date())!
    @State var allowText: String = "ESSEN"
    @State var allowColor: Color = Color.green
    @State var started: Bool = false
    @State var restartTimer: Bool = false;
    
    var body: some View {
        NavigationView {
            TabView {
                //first tab
                 ZStack {
                    VStack {
                        Circle().fill(self.allowColor).frame(width: 250, height: 250).overlay(
                            Text(self.allowText).fontWeight(.bold).font(.system(size: 40, design: .rounded))
                                .foregroundColor(.white)
                            )
                        CounterView(referenceDate: toDate, allowText: $allowText, allowColor: $allowColor, started: $started, restartCounter: $restartTimer)
                    }
                    
                    // floating action button
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: NewIntervalView(restartCounter: $restartTimer)) {
                                Circle().fill(Color.init(red: 1.0, green: 1.0, blue: 1.0)).frame(width: 70, height: 70).shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2).overlay(
                                    Text("+").fontWeight(.bold).font(.system(size: 30, design: .rounded))
                                        .foregroundColor(.black)
                                    ).padding()
                            }
                        }
                    }
                }
                  .tabItem {
                     Image(systemName: "house.fill")
                     Text("Home")
                   }
                
                //second tab
                CalendarView()
                //third tab
                WeightView()
                
            
                
            }
            // topbar
            .navigationBarTitle(Text("Intervallfasten"), displayMode: .inline)
        }.onAppear {
            // load interval from storage
            let defaults = UserDefaults.standard
            if let savedInterval = defaults.object(forKey: "interval") as? Data {
                let decoder = JSONDecoder()
                if let loadedInterval = try? decoder.decode(IntervalModel.self, from: savedInterval) {
                    self.started = true
                    print("loaded interval: \(loadedInterval.intervalTime), \(loadedInterval.startDate)")
                    interval = loadedInterval
                
                    
                    //calculate seconds difference between now and interval start time
                    let diffComponents = Calendar.current.dateComponents([.second], from: interval!.startDate, to: Date())
                    print(diffComponents.second!);
                    var restTimeOfInterval: Int = diffComponents.second!
                    var intervalTimeIndex: Int = 0
                    
                    while (restTimeOfInterval > 0) {
                        print("\(restTimeOfInterval) -  \(interval!.intervalTime.intervalTime[intervalTimeIndex].time)")
                        if(interval!.intervalTime.intervalTime[intervalTimeIndex].time < restTimeOfInterval) {
                            restTimeOfInterval = restTimeOfInterval - interval!.intervalTime.intervalTime[intervalTimeIndex].time
                        } else {
                            restTimeOfInterval = interval!.intervalTime.intervalTime[intervalTimeIndex].time - restTimeOfInterval
                            break;
                        }
                        intervalTimeIndex = intervalTimeIndex + 1
                        if(interval!.intervalTime.intervalTime.count < intervalTimeIndex + 1) {
                            intervalTimeIndex = 0
                        }
                    }
                    print("time left: \(restTimeOfInterval)")
                    self.toDate = Calendar.current.date(byAdding: .second, value: restTimeOfInterval, to: Date())!
                    if(!interval!.intervalTime.intervalTime[intervalTimeIndex].eat) {
                        self.allowText = "FASTEN"
                        self.allowColor = Color.red
                    }
                    print(interval!.intervalTime.intervalTime[intervalTimeIndex].eat)
                    print(interval!.intervalTime.intervalTime[intervalTimeIndex].time)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
