//
//  TagListView.swift
//  DoBday
//
//  Created by chanu on 11/10/24.
//

import SwiftUI
// MARK: - TagListView
// 관계 태그를 표시하는 서브뷰입니다.

struct TagListView: View {
    let tags: [String]
    
    var body: some View {
        if !tags.filter({ !$0.isEmpty }).isEmpty {
            HStack {
                ForEach(tags.filter { !$0.isEmpty }, id: \.self) { tag in
                    Text(tag)
                        .font(.bday_c2Emphasized)
                        .foregroundColor(.black)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.red.opacity(0.3))
                        .cornerRadius(20)
                }
            }
        }
    }
}
