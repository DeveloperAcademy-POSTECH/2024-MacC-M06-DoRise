//
//  DoBdayApp.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI

@main
struct DoBdayApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(bdays: mockBdayData)
        }
        .modelContainer(for: Bday.self)
    }
}
