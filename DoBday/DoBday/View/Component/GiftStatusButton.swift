//
//  SwiftUIView.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//

import SwiftUI

struct GiftStatusButton: View {
    var text: String
    var status: GiftStatusType
    @Binding var currentStatus: GiftStatusType

    
    var body: some View {
        
        Text(text)
            .font(currentStatus == status ? .bday_headEmphasized : .bday_callRegular)
            .foregroundStyle(currentStatus == status ? Color.white : .blue)
            .padding(.vertical, 8)
            .frame(width: 80)
            .background(currentStatus == status ? Color.blue : .blue.opacity(0.2))
            .clipShape(.capsule)
            .onTapGesture {
                currentStatus = status
            }
    }
}

#Preview {
    @Previewable @State var currentStatus: GiftStatusType = .receivedGift
    
    GiftStatusButton(text: "받은 선물", status: .receivedGift, currentStatus: $currentStatus)
    
    GiftStatusButton(text: "준 선물", status: .given, currentStatus: $currentStatus)

}
