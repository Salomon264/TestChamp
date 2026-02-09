import SwiftUI

// Компонент адаптивная кнопка
public struct AdaptiveButton: View {
    public let title: String
    public let width: CGFloat?
    public let height: CGFloat?
    public let fontSize: CGFloat
    public let backgroundColor: Color?
    public let textColor: Color?
    public let style: ButtonStyle
    public let action: () -> Void
    
    // Перечисление стилей кнопки
    public enum ButtonStyle {
        case primary, borderless
    }
    
    public init(
        title: String,
        width: CGFloat? = 335,
        height: CGFloat? = 56,
        fontSize: CGFloat = 16,
        backgroundColor: Color? = .blue,
        textColor: Color? = .white,
        style: ButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.width = width
        self.height = height
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        switch style {
            // первый стиль
        case .primary:
            Button(action: action){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width, height: height)
                        .foregroundColor(backgroundColor)
                    
                    Text(title)
                        .font(Font.system(size: fontSize, weight: .semibold, design: .rounded))
                        .foregroundColor(textColor)
                }
            }
            //второй стиль
        case .borderless:
            Button(action: action){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width, height: height)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(textColor ?? .blue, lineWidth: 1)
                        )
                    
                    Text(title)
                        .font(Font.system(size: fontSize, weight: .semibold, design: .rounded))
                        .foregroundColor(textColor)
                }
            }
        }
    }
}

#Preview {
    AdaptiveButton(title: "Подтвердить", width: 335, height: 56, fontSize: 16, textColor: .blue, style: .borderless, action: {
        print("")
    })
}
