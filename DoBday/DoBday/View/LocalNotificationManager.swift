//
//  LocalNotificationManager.swift.swift
//  DoBday
//
//  Created by chanu on 10/17/24.
//


import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    let notiCenter = UNUserNotificationCenter.current()
    
    //인증
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notiCenter.requestAuthorization(options: options) { (success, error) in
            
            if success {
                print("인증 완료")
            }
            else {
                print("인증 안됨")
            }
        
            }
        }
    
    //노티 생성
    func scheduleNotification(for name: String, dateOfBday: Date, notiFrequency: [String])
    {
        for frequency in notiFrequency {
            var notificationDate = dateOfBday
            var notificationMessage = ""

            //주기에따른노티문구
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
                continue
            }
            
            //내용
            let content = UNMutableNotificationContent()
            content.title = "🎂BRTH"
            content.body = notificationMessage
            content.sound = .default
            content.badge = 1
            //노티주는시간
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
            dateComponents.hour = 9
            dateComponents.minute = 30

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            print("noti생성")
            
            notiCenter.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
            
            
            
        }
    }
    
    //노티삭제
    func CancelNotification(){
        notiCenter.removeAllPendingNotificationRequests()
        notiCenter.removeAllDeliveredNotifications()
    }
    
    }

