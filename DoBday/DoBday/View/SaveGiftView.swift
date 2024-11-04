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
    @State var giftName: String = ""
    @State var giftPrice: String = ""
    @State var memo: String = ""
    @State private var selectedItem: PhotosPickerItem?
    
    @Namespace var bottomID
    
    @FocusState var isFocused: Bool
    
    
    //    @Bindable var bdayGift: BdayGift
    //    @Query var bdayGift: BdayGift
    //    var bdayGift: BdayGift
    
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
                        
                        makeTextAndField(text: "가격", textField: $giftPrice)
                            .focused($isFocused)
                            .padding(.bottom, 16)
                        
                        
                        Text("메모")
                            .font(.bday_bodyEmphasized)
                        TextEditor(text: $memo)
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
    
    func makeIsToBeGivenButton(text: String) -> some View {
        Text(text)
            .font(.bday_callRegular)
            .foregroundStyle(.blue)
            .padding(.vertical, 8)
            .frame(width: 80)
            .background(.blue.opacity(0.2))
            .clipShape(.capsule)
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
