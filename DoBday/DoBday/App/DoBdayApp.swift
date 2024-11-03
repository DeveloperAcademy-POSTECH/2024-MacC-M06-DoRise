//
//  DoBdayApp.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI

@main
struct DoBdayApp: App {
    @Environment(\.modelContext) var context
    var body: some Scene {
        WindowGroup {
            UpComingBdayView()
                .onAppear {
                    // 앱이 실행될 때 알림 권한 요청입니다.
                    NotificationManager.instance.requestAuthorization()
//                    if let context = context.current {
//                        initializeDefaultTags(context: context)
//                    }
                }
        }
        .modelContainer(for: Bday.self)
        .modelContainer(for: BdayTag.self)
    }
}
