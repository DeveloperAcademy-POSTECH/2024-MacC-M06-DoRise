//
//  Helper+LocalNotificationManager.swift
//  DoBday
//
//  Created by chanu on 10/17/24.
//


import SwiftUI
import UserNotifications

class NotificationManager {
    //싱글톤을 사용하여 여러 곳에서 'NotificationManager'를 사용해야 할 때, 이 인스턴스를 공유할 수 있음.
    static let instance = NotificationManager()

    private let notiCenter = UNUserNotificationCenter.current()
    // 앱 아이콘의 뱃지 숫자. 변수로 처리하여 변경 가능
    private var badgeCount = 0

    /// 사용자가 앱에서 알림을 수신할 수 있도록 권한을 요청하는 메서드입니다.
    func requestAuthorization() {
        // 알림 권한에 필요한 옵션들: 알림, 소리, 뱃지
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notiCenter.requestAuthorization(options: options) { (success, error) in

            if success {
                print("인증 완료") // 권한 승인 시 출력
            }
            else {
                print("인증 안됨")  // 권한 거부 또는 오류 발생 시 출력하며 알림도 작동하지 않음.
            }
        }
    }

    /// 주어진 이름과 생일 날짜, 그리고 알림 주기를 바탕으로 알림을 예약하는 메서드입니다.
    /// - Parameters:
    ///   - name: 이름
    ///   - dateOfBday: 생일 날짜
    ///   - notificationFrequencies: 알림 주기
    func scheduleNotification(for name: String, dateOfBday: Date, notiFrequency: [String]) {
        
        for frequency in notiFrequency {
            var notificationDate = dateOfBday
            var notificationMessage = ""

            // 주기별로 메세지 설정.
            switch frequency {
            case "당일":
                notificationDate = dateOfBday
                notificationMessage = "오늘은 \(name)님의 생일이에요!🎉"

            case "1일 전":
                if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: dateOfBday) {
                    notificationDate = newDate
                    notificationMessage = "내일은 \(name)의 생일이에요! 정말 코앞이네요!"
                }
                
            case "3일 전":
                if let newDate = Calendar.current.date(byAdding: .day, value: -3, to: dateOfBday) {
                    notificationDate = newDate
                    notificationMessage = "🎂\(name)의 생일이 3일 남았습니다. 생일 준비는 완료하셨나요?"
                }
                
            case "7일 전":
                if let newDate = Calendar.current.date(byAdding: .day, value: -7, to: dateOfBday) {
                    notificationDate = newDate
                    notificationMessage = "🎂\(name)의 생일이 일주일 남았습니다. 생일을 미리 준비하세요!"
                }
                
            default:
                continue // 위의 case에 해당하지 않는 경우, 스킵. (즉, ""인 상태)
            }

            // 알림의 내용 설정
            let content = UNMutableNotificationContent()
            content.title = "🎂BRTH"
            content.body = notificationMessage
            content.sound = .default
            
            // 앱 아이콘에 표시될 뱃지 숫자를 증가시킵니다.
            badgeCount += 1
            content.badge = NSNumber(value: badgeCount)

            // 알림을 보낼 시간을 설정합니다. (현재 오전 9시)
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
            dateComponents.hour = 9
            dateComponents.minute = 00

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            print("알림 생성 완료")

            // 알림 센터에 알림 요청 추가
            notiCenter.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// `badgeCount`를 0으로 설정하고 앱 아이콘의 뱃지 숫자를 지웁니다.
    func resetBadgeCount() {
        badgeCount = 0 // 뱃지 숫자 초기화
        UIApplication.shared.applicationIconBadgeNumber = 0 // 앱 아이콘의 뱃지 숫자도 초기화
    }

    /// 모든 예약된 알림과 전달된 알림을 취소하고 뱃지 숫자를 초기화합니다.
    func CancelNotification() {
        notiCenter.removeAllPendingNotificationRequests() // 예약된 모든 알림 삭제
        notiCenter.removeAllDeliveredNotifications() // 이미 전달된 모든 알림 삭제
        resetBadgeCount()
    }
}


