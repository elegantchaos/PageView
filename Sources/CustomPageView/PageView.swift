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

private let previewColors: [Color] = [.red, .blue, .green, .yellow, .orange, .gray, .brown, .cyan]

struct PreviewCustomPageView: View {
    @State private var currentIndex = 0
    @State var showNormal = false

    var body: some View {
        TabView {
            PageView(selection: $currentIndex, indexAlignment: .bottomLeading, indexPadding: 40.0) {
                content
            } index: {
                DotsIndexView(currentIndex: currentIndex, pageCount: previewColors.count)
            }
            .tabItem {
                Text("Custom")
                    .font(.title)
            }
            
            TabView(selection: $currentIndex) {
                ForEach(0..<previewColors.count, id: \.self) { index in
                    previewColors[index]
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .tabItem {
                Text("Standard")
                    .font(.title)
            }
        }
        
    }
    
    var content: some View {
        ForEach(0..<previewColors.count, id: \.self) { index in
            previewColors[index]
                .tag(index)
        }
    }
}

struct CustomPageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewCustomPageView()
    }
}
