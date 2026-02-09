//
//  SearchInput.swift
//  UiKitChamp
//
//  Created by Alik on 1/26/26.
//

import SwiftUI

// Компонент адаптивное поле для поиска
public struct SearchInput: View {
    public let hint: String
    @Binding var text: String
    public let clearButton: () -> Void
    
    public init(hint: String = "", text: Binding<String>, clearButton: @escaping () -> Void) {
        self.hint = hint
        self._text = text
        self.clearButton = clearButton
    }
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 48)
                .padding(.horizontal, 16)
                .foregroundColor(Color(.systemGray6))
            
            HStack{
                Image(systemName: "magnifyingglass").opacity(0.5)
                TextField(hint, text: $text)
                    .frame(height: 48)
                Button(action: clearButton){
                    Image(systemName: "xmark").foregroundColor(.black).opacity(0.5)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
   @State var text = "skjgksjg"
    SearchInput(hint: "search", text: $text, clearButton: {
        text = ""
    })
}
