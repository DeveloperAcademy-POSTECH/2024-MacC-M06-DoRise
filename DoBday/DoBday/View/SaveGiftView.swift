//
//  SaveGiftView.swift
//  DoBday
//
//  Created by 이소현 on 11/4/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct SaveGiftView: View {
    
    // MARK: - Property
    @Environment(\.modelContext) var context
    
    @State var giftStatus: GiftStatusType = .receivedGift
    
    @Namespace var bottomID
    
    @FocusState var isFocused: Bool
    
    // MARK: - SwiftData Initialize
    var bdayGift: BdayGift?
    
    @State var isToBeGiven: Bool = false
    @State var giftName: String = ""
    @State var giftPrice: String? = nil
    @State var giftImage: Data? = nil
    @State var memo: String? = nil
    @State var giftURL: String? = nil
    
    init(bdayGift: BdayGift? = nil) {
        self.bdayGift = bdayGift
        if let bdayGift = bdayGift {
            _isToBeGiven = State(initialValue: bdayGift.isToBeGiven)
            _giftName = State(initialValue: bdayGift.giftName)
            _giftPrice = State(initialValue: bdayGift.giftPrice)
            _giftImage = State(initialValue: bdayGift.giftImage)
            _memo = State(initialValue: bdayGift.memo)
            _giftURL = State(initialValue: bdayGift.giftURL)
        }
    }
    
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    
                    GiftImagePicker(giftImage: $giftImage)
                    
                    GiftStatusSelectionSection(giftStatus: $giftStatus)
                                        
                    VStack(alignment: .leading) {
                        GiftNameSection(giftName: $giftName, isFocused: $isFocused)
                        
                        GiftPriceSection(giftPrice: $giftPrice, isFocused: $isFocused)
                        
                        GiftMemoSection(memo: $memo, isFocused: $isFocused)
                            .id(bottomID)
                    }
                    .onTapGesture {
                        withAnimation {
                            proxy.scrollTo(bottomID, anchor: .bottom)
                        }
                    }
                    
                }
                .padding()
                .navigationTitle("준 선물/받은 선물")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addBdayGift()
                            print(giftName)
                        } label: {
                            Text("추가")
                        }
                        
                        
                    }
                }
                
            }
            .onChange(of: isFocused) { oldValue, newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                    withAnimation {
                        proxy.scrollTo(bottomID, anchor: .center)
                    }
                }
            }
            
            .onTapGesture {
                hideKeyboard()
            }
            
        }
    }
}


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


// MARK: - GiftStatusSelectionSection
struct GiftStatusSelectionSection: View {
    
    @Binding var giftStatus: GiftStatusType
    
    var body: some View {
        HStack {
            GiftStatusButton(text: "받은 선물", status: .receivedGift, currentStatus: $giftStatus)
            GiftStatusButton(text: "준 선물", status: .given, currentStatus: $giftStatus)
        }
        .padding(.bottom)

    }
    
}


// MARK: - GiftNameSection
struct GiftNameSection: View {
    @Binding var giftName: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        LabeledTextField(text: "선물 이름", textField: $giftName)
            .focused(isFocused)
            .padding(.bottom, 16)

    }
}


// MARK: - GiftPriceSection
struct GiftPriceSection: View {
    
    @Binding var giftPrice: String?
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        LabeledTextField(text: "가격", textField: Binding(
            get: { giftPrice ?? "" },
            set: { giftPrice = $0.isEmpty ? nil : $0 }
        ))
        .focused(isFocused)
        .padding(.bottom, 16)

    }
}

// MARK: - GiftMemoSection
struct GiftMemoSection: View {
    @Binding var memo: String?
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        Text("메모")
            .font(.bday_bodyEmphasized)
        TextEditor(text: Binding(
            get: { memo ?? "" },
            set: { memo = $0.isEmpty ? nil : $0 }
        ))
        .focused(isFocused)
        .scrollContentBackground(.hidden)
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}







// MARK: - extension SaveGiftView
extension SaveGiftView {
    
    /// bdayGift를 수정하거나 저장할 수 있는 함수입니다.
    func addBdayGift() {
        isToBeGiven = (giftStatus == .given)    // giftStatus에 따라 isToBeGiven 값을 설정. giftStatus가 .given이면 isToBeGiven은 True가 됨.
        
        
        // 기존 생일 선물 수정
        if let bdayGift = bdayGift {
            print("기존 선물 수정 중")
            bdayGift.isToBeGiven = isToBeGiven
            bdayGift.giftName = giftName
            bdayGift.giftPrice = giftPrice
            bdayGift.giftImage = giftImage
            bdayGift.memo = memo
            bdayGift.giftURL = giftURL
        } else {
            // 새 생일 선물 객체 저장
            let bdayGift = BdayGift(
                id: UUID(),
                isToBeGiven: isToBeGiven,
                giftName: giftName,
                giftPrice: giftPrice,
                giftImage: giftImage,
                memo: memo,
                giftURL: giftURL
                
            )
            
            context.insert(bdayGift)
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
        
    }
}





#Preview {
    NavigationStack {
        SaveGiftView()
    }
    .modelContainer(for: BdayGift.self)
}
