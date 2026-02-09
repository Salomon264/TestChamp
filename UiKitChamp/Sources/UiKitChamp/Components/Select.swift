//
//  Select.swift
//  UiKitChamp
//
//  Created by Alik on 1/26/26.
//

import SwiftUI

// Компонент адаптивный селект
public struct Select: View{
    public let title: String
    public let options: [String]
    @Binding public var selectedOption: String?
    
    @State private var isExpanded: Bool = false
    
    public init(title: String = "", options: [String], selectedOption: Binding<String?>) {
        self.title = title
        self.options = options
        self._selectedOption = selectedOption
    }
    
    public var body: some View {
        VStack{
            Text(title)
                .font(.headline)
            
            Button {
                withAnimation(.spring(duration: 0.3)){
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(selectedOption ?? "Выберите")
                        .foregroundColor(selectedOption == nil ? .gray : .black)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                
                if isExpanded {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Button {
                                selectedOption = option
                                withAnimation {
                                    isExpanded = false
                                }
                            } label: {
                                HStack {
                                    Text(option)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    if selectedOption == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                            }
                            
                            if option != options.last {
                                Divider()
                            }
                        }
                    }
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(40)
            .cornerRadius(12)
        }
    }
}

#Preview {
    let options: [String] = ["1", "2", "4"]
    Select(options: options, selectedOption: .constant(options[0]))
}
