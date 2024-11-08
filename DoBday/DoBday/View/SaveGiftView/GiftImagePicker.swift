//
//  GiftImagePicker.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//


import SwiftUI
import PhotosUI

// MARK: - GiftImagePicker
struct GiftImagePicker: View {
    
    @State var selectedItem: PhotosPickerItem?
    @Binding var giftImage: Data?
    
    var body: some View {
        
        if let imageData = giftImage, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 142, height: 171) // 원하는 크기로 조정
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 142, height: 171)
                        .foregroundStyle(.gray.opacity(0.2))
                    
                    Image(systemName: "photo.badge.plus")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
            }
            .onChange(of: selectedItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        giftImage = data
                    }
                }
            }
        }
    }
}
