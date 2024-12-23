//
//  Extension+View.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//

import Foundation
import SwiftUI

extension View {
    
    /// 키보드를 숨기는 함수입니다. 현재 입력 중인 View(텍스트 필드 등)을 비활성화시켜 키보드를 화면에서 사라지게 합니다.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// GiveOrTakeTag의 Text에 쓰이는 ViewModifier 입니다.
    func giveOrTakeTagTextViewModifier(_ color: Color) -> some View { self
        .font(.bday_c2Emphasized)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(color)
        .clipShape(.capsule)
    }

}
