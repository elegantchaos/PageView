// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct DotsIndexView<SelectionValue>: View where SelectionValue: Hashable, SelectionValue: Identifiable {
    @Binding var selection: SelectionValue
    
    let pages: [SelectionValue]
    
    let dotSize: CGFloat
    let dotSpacing: CGFloat
    let dotColor: Color

    let selectedScale: CGFloat
    let selectedColor: Color
    
    public init(selection: Binding<SelectionValue>, pages: [SelectionValue], dotSize: CGFloat = 8, dotSpacing: CGFloat = 10, dotColor: Color = Color.white.opacity(0.5), selectedScale: CGFloat = 1.0, selectedColor: Color = .white) {
        self._selection = selection
        self.pages = pages
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.dotColor = dotColor
        self.selectedScale = selectedScale
        self.selectedColor = selectedColor
    }
    
    public var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(pages) { page in
                Circle()
                    .fill(page == selection ? selectedColor : dotColor)
                    .scaleEffect(page == selection ? selectedScale : 1.0)
                    .frame(width: dotSize, height: dotSize)
                    .transition(AnyTransition.opacity.combined(with: .scale))
                    .id(page)
            }
        }
    }
}
