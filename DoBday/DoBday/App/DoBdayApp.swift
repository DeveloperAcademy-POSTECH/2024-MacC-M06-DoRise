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

//    @State private var isFirstTime: Bool = UserDefaults.standard.bool(forKey: "isFirstTime")
    @AppStorage("isFirstTime") private var isFirstTime = false

    var container: ModelContainer

        init() {
            do {
                let config = ModelConfiguration(for: Bday.self, BdayTag.self, GiftStatus.self, BdayGift.self)
                container = try ModelContainer(for: Bday.self, BdayTag.self, GiftStatus.self, BdayGift.self, configurations: config)
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
                    
                    // 사용자가 앱을 열 때 호출되어 알림 카운트를 리셋.

                    NotificationManager.instance.resetBadgeCount()

                    print(isFirstTime)
                    if !isFirstTime {
                        addDefaultTags(context: container.mainContext)
                    }
                    self.isFirstTime = true
                    print(isFirstTime)


                }
        }

        .modelContainer(container)

    }
}
