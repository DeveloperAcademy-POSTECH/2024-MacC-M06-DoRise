//
//  File.swift
//  DoBday
//
//  Created by 이소현 on 11/9/24.
//
import SwiftUI
import PhotosUI

struct PhotoCircle: View {
    var profileImage: Data?
    var alternativeImage: String
    
    var body: some View {
        if let profileImage = profileImage, let uiImage = UIImage(data: profileImage) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.trailing, 10)
        } else {
            Image(alternativeImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.trailing, 10)
        }
    }
}



