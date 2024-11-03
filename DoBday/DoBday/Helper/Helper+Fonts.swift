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
    case dateTitle = "Zen Dots"
}

extension Font {
    // MARK: - Large Title
    static let ltEmphasized = Font.custom("Pretendard-Bold", size: 48)
    static let ltRegular = Font.custom("Pretendard-Regular", size: 48)
    
    // MARK: - Title1
    static let t1Emphasized = Font.custom("Pretendard-Bold", size: 36)
    static let t1Regular = Font.custom("Pretendard-Regular", size: 36)

    // MARK: - Title2
    static let t2Emphasized = Font.custom("Pretendard-Bold", size: 22)
    static let t2Regular = Font.custom("Pretendard-Regular", size: 22)

    // MARK: - Title3
    static let t3Emphasized = Font.custom("Pretendard-Bold", size: 18)
    static let t3Regular = Font.custom("Pretendard-Regular", size: 18)
    
    // MARK: - Headline
    static let headEmphasized = Font.custom("Pretendard-Bold", size: 16)
    // MARK: - Body
    static let bodyEmphasized = Font.custom("Pretendard-SemiBold", size: 16)
    static let bodyRegular = Font.custom("Pretendard-Regular", size: 16)
    
    // MARK: - Callout
    static let  callEmphasized = Font.custom("Pretendard-Bold", size: 14)
    static let  collRegular = Font.custom("Pretendard-Regular", size: 14)
    
    // MARK: - Sub Headline
    static let subEmphasized = Font.custom("Pretendard-Bold", size: 13)
    static let subRegular = Font.custom("Pretendard-Regular", size: 13)
    
    // MARK: - Foot Note
    static let footEmphasized = Font.custom("Pretendard-Bold", size: 12)
    static let footRegular = Font.custom("Pretendard-Regular", size: 12)
    
    // MARK: - Caption1
    static let c1Emphasized = Font.custom("Pretendard-Bold", size: 11)
    static let c1Regular = Font.custom("Pretendard-Regular", size: 11)
    
    // MARK: - Caption2
    static let c2Emphasized = Font.custom("Pretendard-Bold", size: 10)
    static let c2Regular = Font.custom("Pretendard-Regular", size: 10)
    
    // MARK: - DateFormat Title
    /// UpcomingView에 사용할 때 lineSpacing(25) 적용하고 사용하면 똑같아짐
    static let bdayEmphasized = Font.custom("Zen dots", size: 32)
}
