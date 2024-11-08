//
//  Component.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI

struct LabeledTextField: View {
    var text: String
    @Binding var textField: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.bday_bodyEmphasized)
            TextField("", text: $textField)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    @Previewable @State var textField: String = "텍스트필드"
    
    LabeledTextField(text: "이름", textField: $textField)
}
