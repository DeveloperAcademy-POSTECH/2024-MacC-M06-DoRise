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
    @State private var selectedItem: PhotosPickerItem?
    
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
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 140, height: 160)
                                .foregroundStyle(.gray.opacity(0.2))
                            
                            Image(systemName: "photo.badge.plus")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        makeIsToBeGivenButton(text: "받은 선물")
                        makeIsToBeGivenButton(text: "준 선물")
                    }
                    .padding(.bottom)
                    
                    
                    VStack(alignment: .leading) {
                        makeTextAndField(text: "선물 이름", textField: $giftName)
                            .focused($isFocused)
                            .padding(.bottom, 16)
                        
                        makeTextAndField(text: "가격", textField: Binding(
                            get: { giftPrice ?? "" },
                            set: { giftPrice = $0.isEmpty ? nil : $0 }
                        ))
                            .focused($isFocused)
                            .padding(.bottom, 16)
                        
                        
                        Text("메모")
                            .font(.bday_bodyEmphasized)
                        TextEditor(text: Binding(
                            get: { memo ?? "" },
                            set: { memo = $0.isEmpty ? nil : $0 }
                        ))
                            .focused($isFocused)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .background(.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .id(bottomID)
                    }
                    .onTapGesture {
                        withAnimation {
                            proxy.scrollTo(bottomID, anchor: .bottom)
                        }
                    }
                    
                }
                .padding()
                .navigationTitle("주고 싶은 선물")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
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




// MARK: - extension SaveGiftView
extension SaveGiftView {
    /// Text와 TextField를 생성하는 함수입니다.
    func makeTextAndField(text: String, textField: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.bday_bodyEmphasized)
            TextField("", text: textField)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    /// isToBeGivenButton을 생성하는 함수입니다.
    func makeIsToBeGivenButton(text: String) -> some View {
        Text(text)
            .font(.bday_callRegular)
            .foregroundStyle(.blue)
            .padding(.vertical, 8)
            .frame(width: 80)
            .background(.blue.opacity(0.2))
            .clipShape(.capsule)
    }
    
    /// bdayGift를 수정하거나 저장할 수 있는 함수입니다. 
    func addBdayGift() {
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
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    NavigationStack {
        SaveGiftView()
    }
    .modelContainer(for: BdayGift.self)
}
