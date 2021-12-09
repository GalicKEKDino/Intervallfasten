//
//  IntervalModel.swift
//  Intervallfasten
//
//  Created by Galic Dino on 09.12.21.
//

import Foundation

let ONE_HOUR: Int = 60*60
let ONE_DAY: Int = ONE_HOUR*24

enum Types: String, CaseIterable, Identifiable {
    case _16_8
    case _5_2
    case _1_1
    case test

    var id: String { self.rawValue }
}

public struct Phase: Codable {
    var eat: Bool
    var time: Int
}

public struct IntervalTime: Codable {
    //1 parameter: allow eat, 2 parameter: Time in Seconds till next
    var intervalTime: [Phase]
}

open class IntervalModel: NSObject, Codable {
    public var startDate: Date
    public var intervalTime: IntervalTime
    
    init(type: Types, startDate: Date) {
        
        //include all types of Types
        switch type {
            case Types._16_8:
                self.intervalTime = IntervalTime.init(intervalTime: [Phase(eat: true, time: ONE_HOUR*16)])
                self.intervalTime.intervalTime.append(Phase(eat: false, time: ONE_HOUR*8))
                break
            case Types._5_2:
                self.intervalTime = IntervalTime.init(intervalTime: [Phase(eat: true, time: ONE_DAY*5)])
                self.intervalTime.intervalTime.append(Phase(eat: false, time: ONE_DAY*2))
                break
        case Types.test:
                self.intervalTime = IntervalTime.init(intervalTime: [Phase(eat: true, time: ONE_HOUR/360)])
                self.intervalTime.intervalTime.append(Phase(eat: false, time: ONE_HOUR/360))
                break
            default: //default: Types._1_1
                self.intervalTime = IntervalTime.init(intervalTime: [Phase(eat: true, time: ONE_DAY)])
                self.intervalTime.intervalTime.append(Phase(eat: false, time: ONE_DAY))
                break
        }
        
        self.startDate = startDate
    }
    
    init(intervalTime: IntervalTime, startDate: Date) {
        self.intervalTime = intervalTime
        self.startDate = startDate
    }
}
