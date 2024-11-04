//
//  Helper+Color.swift
//  DoBday
//
//  Created by chanu on 10/17/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

//extension Color {
//    static let BdayRed = Color.init(hex: <#T##String#>)
//}

extension Color {
    static let titleDayOfWeekColor = Color(hex: "FFB71B") // 원하는 색상 추가
    static let upComingBdayCardBackgroundColor = Color(hex: "D9D9D9")

}
