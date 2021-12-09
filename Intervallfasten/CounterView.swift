//
//  CounterView.swift
//  Intervallfasten
//
//  Created by Galic Dino on 09.12.21.
//

import SwiftUI

struct CounterView: View {
    @State var nowDate: Date = Date()
    @State var referenceDate: Date
    @State var allowEat: Bool = true
    @State var currentTimerIndex: Int = 0
    @Binding var allowText: String
    @Binding var allowColor: Color
    @Binding var started: Bool
    @Binding var restartCounter: Bool
    
    var body: some View {
        Text(countDownString(from: referenceDate))
            .fontWeight(.bold)
            .font(.system(size: 30))
            .onAppear(perform: {
                _ = self.timer
            })
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            self.nowDate = Date();
            
            if(self.restartCounter) {
                referenceDate = Calendar.current.date(byAdding: .second, value: interval!.intervalTime.intervalTime[0].time, to: Date())!
                self.restartCounter = false
            }
            
            if(referenceDate < nowDate) {
                if(interval != nil) {
                        self.currentTimerIndex = self.currentTimerIndex + 1;
                        if(interval!.intervalTime.intervalTime.count < self.currentTimerIndex + 1) {
                            self.currentTimerIndex = 0;
                        }
                        referenceDate = Calendar.current.date(byAdding: .second, value: interval!.intervalTime.intervalTime[self.currentTimerIndex].time, to: Date())!
                        allowEat = interval!.intervalTime.intervalTime[self.currentTimerIndex].eat
                        if(self.allowEat) {
                            self.allowText = "ESSEN"
                            self.allowColor = Color.green
                        } else {
                            self.allowText = "FASTEN"
                            self.allowColor = Color.red
                        }
                        
                    //}
                } else {
                    referenceDate = Calendar.current.date(byAdding: .second, value: 0, to: Date())!
                }
            }
        }
    }
    
    
    func countDownString(from date: Date) -> String {
        let calender = Calendar(identifier: .gregorian)
        let components = calender
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: referenceDate)
        
        return String(format: "%02d:%02d:%02d:%02d",
                      components.day!,
                      components.hour!,
                      components.minute!,
                      components.second!)
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(referenceDate: Date(), allowText: .constant("ESSEN"), allowColor: .constant(Color.green), started: .constant(false), restartCounter: .constant(false))
    }
}

