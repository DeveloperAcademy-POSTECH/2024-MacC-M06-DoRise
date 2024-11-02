//
//  Previewer.swift
//  DoBday
//
//  Created by 이소현 on 11/2/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let bday: Bday
    let bdayTag: BdayTag
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        container = try ModelContainer(for: Bday.self, configurations: config)
        
        bday = Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스")
        
        bdayTag = BdayTag(id: UUID(), tagName: "#애플아카데미")
        
        container.mainContext.insert(bday)
    }
}
