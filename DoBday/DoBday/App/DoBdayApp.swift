//
//  DoBdayApp.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData

@main
struct DoBdayApp: App {
//    @Environment(\.modelContext) var context

    var container: ModelContainer

        init() {
            do {
                let config = ModelConfiguration(for: Bday.self, BdayTag.self)
                container = try ModelContainer(for: Bday.self, BdayTag.self, configurations: config)
            } catch {
                fatalError("Failed to configure SwiftData container.")
            }
        }

    var body: some Scene {
        WindowGroup {
            UpComingBdayView()
//            GiveAndTakeView()
                .onAppear {
                    // 앱이 실행될 때 알림 권한 요청입니다.
                    NotificationManager.instance.requestAuthorization()
//                    if let context = context.current {
//                        initializeDefaultTags(context: context)
//                    }
                }
        }
        .modelContainer(container)
    }
}
