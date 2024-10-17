//
//  MockupData.swift
//  DoBday
//
//  Created by 이소현 on 10/17/24.
//

import Foundation
import SwiftUI

let mockBdayData: [Bday] = [
    Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: Date(), isLunar: false, notiFrequency: "Weekly"),
    Bday(id: UUID(), name: "씨네필", profileImage: "cinephil", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()), isLunar: false, notiFrequency: "Daily"),
    Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .month, value: 1, to: Date()), isLunar: true, notiFrequency: "Monthly"),
    Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .month, value: -3, to: Date()), isLunar: false, notiFrequency: "Weekly")
]
