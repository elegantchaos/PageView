// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 07/07/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct VStackPageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View  {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    let indexAlignment: HorizontalAlignment
    let indexPadding: CGFloat?
    
    public init(selection: Binding<SelectionValue>, indexAlignment: HorizontalAlignment = .center, indexPadding: CGFloat? = nil, content: @escaping () -> Content, index: @escaping () -> Index) {
        self._selection = selection
        self.content = content
        self.index = index
        self.indexAlignment = indexAlignment
        self.indexPadding = indexPadding
    }
    
    public var body: some View {
        VStack(alignment: indexAlignment) {
            TabView(selection: $selection.animation()) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            index()
                .padding(.all, indexPadding)
            
        }
    }
}
