//
//  Input.swift
//  UiKitChamp
//
//  Created by Alik on 1/25/26.
//

import SwiftUI

//Структура поля ввода
public struct Input: View {
    //Атрибуты для адаптивности компонента
    let label: String
    let alertMessаge: String
    let hint: String
    var isPassword: Bool
    var isAlert: Bool
    @Binding var isPasswordVisible: Bool
    @Binding var text: String
    
    //Инициализатор атрибутов
    public init(label: String = "", alertMessage: String = "", hint: String = "", isPassword: Bool, isAlert: Bool = false, isPasswordVisible: Binding<Bool>, text: Binding<String>) {
        self.label = label
        self.alertMessаge = alertMessage
        self.hint = hint
        self.isPassword = isPassword
        self.isAlert = isAlert
        self._isPasswordVisible = isPasswordVisible
        self._text = text
    }
        
    //Исполняемое тело компонента
    public var body: some View {
        //Вертикальный контейнер
        VStack{
            //Загаловок поля
            Text(label)
                .font(Font.system(size: 14, weight: .regular, design: .default))
                .opacity(0.6)
                .offset(x: -150)
            //Если не поле для ввода пароля
            if !isPassword {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isAlert ? Color.red : Color.clear, lineWidth: 1)
                        )
                        .frame(width: 335, height: 48)
                        .foregroundColor(isAlert ? .red.opacity(0.1) : Color(.systemGray6))
                    TextField("", text: $text)
                        .frame(width: 250, height: 48)
                }
                //Если поле для ввода пароля
            }else if isPassword {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isAlert ? Color.red : Color.clear, lineWidth: 1)
                        )
                        .frame(width: 335, height: 48)
                        .foregroundColor(isAlert ? .red.opacity(0.1) : Color(.systemGray6))
                    //Если пароль невидим
                    if !isPasswordVisible{
                        HStack{
                            SecureField("", text: $text)
                                .frame(width: 250, height: 48)
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: "eye")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                            }
                        }
                        //Пароль видим
                    }else{
                        HStack{
                            TextField("", text: $text)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isAlert ? Color.red : Color.clear, lineWidth: 1)
                                )
                                .frame(width: 250, height: 48)
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: "eye.slash")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Input(label: "Имя", isPassword: true, isAlert: true, isPasswordVisible: .constant(false), text: .constant("fkmkfm"))
}
