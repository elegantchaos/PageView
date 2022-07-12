// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 07/07/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct VStackPageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    let indexAlignment: HorizontalAlignment
    let indexPadding: CGFloat?

    public init(selection: Binding<SelectionValue>, indexAlignment: HorizontalAlignment = .center, indexPadding: CGFloat? = nil, content: @escaping () -> Content, index: @escaping () -> Index) {
        _selection = selection
        self.content = content
        self.index = index
        self.indexAlignment = indexAlignment
        self.indexPadding = indexPadding
    }

    public var body: some View {
        VStack(alignment: indexAlignment) {
            TabView(selection: $selection) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            index()
                .padding(.all, indexPadding)
        }
    }
}

struct VStackPageView_Previews: PreviewProvider {
    struct ExampleView: View {
        @State private var selection = previewColors.first!
        @State var showNormal = false

        var body: some View {
            VStackPageView(selection: $selection, indexAlignment: .leading, indexPadding: 40.0) {
                content
            } index: {
                DotsIndexView(selection: $selection, pages: previewColors)
            }
            .tabItem {
                Text("Leading Dots")
                    .font(.title)
            }
        }

        var content: some View {
            ForEach(previewColors) { color in
                color
                    .tag(color)
            }
        }
    }

    static var previews: some View {
        ExampleView()
    }
}
