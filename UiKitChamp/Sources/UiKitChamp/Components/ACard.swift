//
//  ACard.swift
//  UiKitChamp
//
//  Created by Alik on 2/3/26.
//

import SwiftUI

// компонент адаптивная карточка
public struct ACard<Content: View>: View {
    // содержимое карточки
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .frame(width: 335, height: 138)
                .shadow(color: .gray.opacity(0.3), radius: 4, y: 2)
        )
    }
}

#Preview {
    ACard {
        VStack{
            //
        }
    }
}
