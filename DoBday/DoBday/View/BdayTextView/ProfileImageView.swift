//
//  ProfileImageView.swift
//  DoBday
//
//  Created by chanu on 11/10/24.
//

import SwiftUI
// MARK: - ProfileImageView
// 프로필 이미지를 표시하는 뷰입니다. 이미지가 없으면 기본 이미지를 표시합니다.

struct ProfileImageView: View {
    let profileImage: Data?
    
    var body: some View {
            if let profileImage = profileImage, let uiImage = UIImage(data: profileImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(45)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            } else {
                Image("basicprofile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(45)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
    }
}
