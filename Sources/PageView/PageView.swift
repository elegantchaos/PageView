import SwiftUI


public struct PageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View  {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    let indexAlignment: Alignment
    let indexPadding: CGFloat?
    
    public init(selection: Binding<SelectionValue>, indexAlignment: Alignment = .bottom, indexPadding: CGFloat? = nil, content: @escaping () -> Content, index: @escaping () -> Index) {
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

extension Color: Identifiable {
    public var id: Color { return self }
}
struct PreviewCustomPageView: View {
    @State private var selection = previewColors.first!
    @State var showNormal = false

    var body: some View {
        TabView {
            PageView(selection: $selection, indexAlignment: .bottomLeading, indexPadding: 40.0) {
                content
            } index: {
                DotsIndexView(selection: $selection, pages: previewColors)
            }
            .tabItem {
                Text("Leading Dots")
                    .font(.title)
            }

            PageView(selection: $selection, indexAlignment: .top, indexPadding: 40.0) {
                content
            } index: {
                DotsIndexView(selection: $selection, pages: previewColors, selectedScale: 1.6)
            }
            .tabItem {
                Text("Top Dots Growing")
                    .font(.title)
            }

            TabView(selection: $selection) {
                ForEach(previewColors) { color in
                    color
                        .tag(color)
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
        ForEach(previewColors) { color in
            color
                .tag(color)
        }
    }
}

struct CustomPageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewCustomPageView()
    }
}
