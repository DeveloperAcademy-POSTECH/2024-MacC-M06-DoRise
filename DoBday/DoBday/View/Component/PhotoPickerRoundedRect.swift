//
//  PhotoPicker.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerRoundedRect: View {
    var imageData: Data?
    var alternativeImage: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        // 선물 이미지 (이미지가 없으면 기본 이미지 표시)
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(8)
        } else {
            Image(alternativeImage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(8)
        }

    }
}

#Preview {
    PhotoPickerRoundedRect(alternativeImage: "starrynight", width: 64, height: 64)
}
