// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct DotsIndexView<SelectionValue>: View where SelectionValue: Hashable {
    @Binding var selection: SelectionValue

    let pages: [SelectionValue]

    let dotSize: CGFloat
    let dotSpacing: CGFloat
    let dotColor: Color

    let selectedScale: CGFloat
    let selectedColor: Color

    public init(selection: Binding<SelectionValue>, pages: [SelectionValue], dotSize: CGFloat = 8, dotSpacing: CGFloat = 10, dotColor: Color = Color.primary.opacity(0.2), selectedScale: CGFloat = 1.0, selectedColor: Color = .primary) {
        _selection = selection
        self.pages = pages
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.dotColor = dotColor
        self.selectedScale = selectedScale
        self.selectedColor = selectedColor
    }

    public var body: some View {
        let selectedIndex = pages.firstIndex(of: selection)
        let indices = 0 ..< pages.count
        return HStack(spacing: dotSpacing) {
            ForEach(indices, id: \.self) { index in
                Circle()
                    .fill(index == selectedIndex ? selectedColor : dotColor)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            selection = pages[index]
                        }
                    }
                    .scaleEffect(index == selectedIndex ? selectedScale : 1.0)
                    .frame(width: dotSize, height: dotSize)
                    .transition(AnyTransition.opacity.combined(with: .scale))
                    .id(index)
            }
        }
    }
}
