//
//  MockupData.swift
//  DoBday
//
//  Created by 이소현 on 10/17/24.
//

import Foundation
import SwiftUI

let mockBdayData: [Bday] = [
    Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isLunar: false, notiFrequency: ["당일"], relationshipTag: ["#가족"]),
    Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: ["#비지니스"]),
    Bday(id: UUID(), name: "씨네필", profileImage: "cinephile", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()), isLunar: false, notiFrequency: ["3일 전"], relationshipTag: ["#지인"]),
    Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .month, value: 1, to: Date()), isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: ["#친구"])
]
