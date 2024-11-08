//
//  Extension+Image.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//

import SwiftUI


extension Image {
    /// GiftCardView에서 Img에 쓰이는 ViewModifier입니다.
    func giftCardViewImgViewModifier() -> some View { self
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 80)
        .clipShape(.rect(cornerRadius: 20))
    }
}
