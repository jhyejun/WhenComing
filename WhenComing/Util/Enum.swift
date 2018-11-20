//
//  Enum.swift
//  WhenComing
//
//  Created by 장혜준 on 20/11/2018.
//  Copyright © 2018 장혜준. All rights reserved.
//

import Foundation

enum DayOfWeekType: String, CaseIterable {
    case Monday = "1"
    case Tuesday = "2"
    case Wednesday = "3"
    case Thursday = "4"
    case Friday = "5"
    case Saturday = "6"
    case Sunday = "7"
    
    var dayString: String {
        switch self {
        case .Monday:
            return "월"
        case .Tuesday:
            return "화"
        case .Wednesday:
            return "수"
        case .Thursday:
            return "목"
        case .Friday:
            return "금"
        case .Saturday:
            return "토"
        case .Sunday:
            return "일"
        }
    }
}
