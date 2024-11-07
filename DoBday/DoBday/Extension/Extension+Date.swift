//
//  Untitled.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//
import SwiftUI

// MARK: - extension Date

extension Date {
    /// 주어진 date의 가장 첫번째 순간을 반환하는 함수입니다.
    /// 예를 들어 11월의 startOfDay는 1일입니다.
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func isSameDate(date: Date) -> Bool {
        self.startOfDay() == date.startOfDay()
    }
    
}
