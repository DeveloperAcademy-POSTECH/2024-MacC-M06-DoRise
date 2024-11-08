//
//  CustomCheckBox.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - CustomCheckBox
struct CustomCheckBox: View {
    var isChecked: Bool
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(color, lineWidth: 2)
                .background(Circle().fill(Color.white))
                .frame(width: 20, height: 20)
            
            if isChecked {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .background(Circle().fill(color)) // `color` 값을 사용해 조건부 색상 설정.
            }
        }
    }
}
