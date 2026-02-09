//
//  ATabBar.swift
//  UiKitChamp
//
//  Created by Alik on 2/3/26.
//

import SwiftUI


// Компонент адаптивный таб бар
public struct ATabBar: View {
    //@State private var selectedTab = 0
    //
    //let tabs = ["Главная", "Каталог", "Проекты", "Профиль"]
    //let icons = ["house", "book", "folder", "person"]
    
    @Binding public var selectedTab: Int
    public let tabs: [String]
    public let icons: [String]
    
    public init(selectedTab: Binding<Int>, tabs: [String], icons: [String]) {
        self._selectedTab = selectedTab
        self.tabs = tabs
        self.icons = icons
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Контент вкладок
            TabView(selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text("Экран \(tabs[index])")
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // Кастомный таб бар
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: icons[index])
                                .font(.system(size: 22))
                            
                            Text(tabs[index])
                                .font(.system(size: 12))
                        }
                        .foregroundColor(selectedTab == index ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 20)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3)),
                alignment: .top
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

