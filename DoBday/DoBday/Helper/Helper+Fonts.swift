//
//  Helper+Fonts.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import Foundation
import SwiftUI

enum Pretendard: String {
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
}

extension Font {
    // TODO: 폰트 추가하기
    static let BdayLargeTitle = Font.custom("Pretendard-Black", size: 48)

    static let BdayTitle1 = Font.custom("Pretendard-Bold", size: 36)

    static let BdayButton = Font.custom("Pretendard-ExtraBold", size: 16)

    static let BdayoBody = Font.custom("Pretendard-ExtraLight", size: 12)

    static let BdayBody1 = Font.custom("Pretendard-Light", size: 10)

    static let BdayBody2 = Font.custom("Pretendard-Medium", size: 10)

    static let BdayoBody3 = Font.custom("Pretendard-Regular", size: 10)

    static let BdayBody4 = Font.custom("Pretendard-SemiBold", size: 10)

    static let BdayBody5 = Font.custom("Pretendard-Thin", size: 10)

}

