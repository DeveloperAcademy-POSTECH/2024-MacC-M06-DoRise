

import SwiftUI
import KoreanLunarSolarConverter

class KoreanLunarSolarConverter {
    
    static let instance = KoreanLunarSolarConverter()
    
    func solarToLunar(date: Date) -> Date? {
        let converter = KoreanSolarToLunarConverter()
        do {
            let lunarDate = try converter.lunarDate(fromSolar: date)
            return lunarDate.date
        } catch {
            print("음력 변환 실패")
            return nil
        }
    }
    
    // 음력 -> 현재 연도 양력 변환 함수
    func convertLunarToSolarForCurrentYear(lunarDate: Date) -> Date? {
        let converter = KoreanLunarToSolarConverter()
        let currentYear = Calendar.current.component(.year, from: Date()) // 현재 연도
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: lunarDate)
        components.year = currentYear // 현재 연도로 설정
        
        if let updatedLunarDate = Calendar.current.date(from: components) {
            do {
                let convertedSolarDate = try converter.solarDate(fromLunar: updatedLunarDate)
                return convertedSolarDate.date
            } catch {
                print("양력 변환 실패")
                return nil
            }
        }
        return nil
    }
    
}
