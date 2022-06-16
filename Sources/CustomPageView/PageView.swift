import SwiftUI


public struct PageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View  {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    let indexAlignment: Alignment
    let indexPadding: CGFloat?
    
    internal init(selection: Binding<SelectionValue>, indexAlignment: Alignment = .bottom, indexPadding: CGFloat? = nil, content: @escaping () -> Content, index: @escaping () -> Index) {
        self._selection = selection
        self.content = content
        self.index = index
        self.indexAlignment = indexAlignment
        self.indexPadding = indexPadding
    }

    public var body: some View {
        ZStack(alignment: indexAlignment) {
            TabView(selection: $selection.animation()) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            index()
                .padding(.all, indexPadding)

        }
    }
}

struct PreviewCustomPageView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow]
    @State private var currentIndex = 0
    
    var body: some View {
        PageView(selection: $currentIndex, indexAlignment: .bottomLeading, indexPadding: 40.0) {
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
