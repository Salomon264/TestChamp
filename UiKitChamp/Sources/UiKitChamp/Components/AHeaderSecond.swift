//
//  AHeaderSecond.swift
//  UiKitChamp
//
//  Created by Alik on 2/3/26.
//

import SwiftUI

//Компонент второй стиль для хэдера
public struct AHeaderSecond: View {
    public let title: String
    public let action: () -> Void
    public let deleteAction: () -> Void
    
    public init(title: String, action: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.deleteAction = deleteAction
    }
    public var body: some View {
        HStack{
            Button(action: action){
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.lightGray).opacity(0.2))
                            .frame(width: 32, height: 32)
                    )
            }
            
            Spacer()
            
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.primary)
                .padding(.horizontal, 16)
            
            Spacer()
            
            Button(action: deleteAction){
                Image(systemName: "trash")
                    .foregroundColor(Color(.lightGray))
                    .fontWeight(.semibold)
                    .font(Font.system(size: 20))
            }
        }
        .padding()
    }
}

#Preview {
    AHeaderSecond(title: "Cart", action: {}, deleteAction: {})
}
