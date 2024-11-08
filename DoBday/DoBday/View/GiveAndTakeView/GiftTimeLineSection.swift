//
//  GiftTimeLineSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftTimeLineSection
struct GiftTimeLineSection: View{
    var body: some View {
        // 타임라인 효과를 위한 세로 선
        HStack {
            Rectangle()
                .frame(width: 1)
                .frame(maxHeight: .infinity)
                .padding(.leading, 12)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
