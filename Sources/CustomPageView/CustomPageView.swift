import SwiftUI


public struct CustomPageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View  {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    
    public var body: some View {
        TabView(selection: $selection.animation()) {
            content()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(index()) // 2
    }
}

struct PreviewCustomPageView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow]
    @State private var currentIndex = 0
    
    var body: some View {
        CustomPageView(selection: $currentIndex) {
            ForEach(0..<colors.count, id: \.self) { index in
              colors[index]
                .tag(index)
            }
        } index: {
            FunkyDotsIndexView(currentIndex: currentIndex, pageCount: colors.count)
        }
    }
}

struct CustomPageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCustomPageView()
    }
}
