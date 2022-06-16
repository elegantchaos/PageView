// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct DotsIndexView: View {
    
    let currentIndex: Int
    let pageCount: Int
    
    let dotSize: CGFloat
    let dotSpacing: CGFloat
    let dotColor: Color

    let selectedScale: CGFloat
    let selectedColor: Color
    
    init(currentIndex: Int, pageCount: Int, dotSize: CGFloat = 8, dotSpacing: CGFloat = 10, dotColor: Color = Color.white.opacity(0.5), selectedScale: CGFloat = 1.0, selectedColor: Color = .white) {
        self.currentIndex = currentIndex
        self.pageCount = pageCount
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.dotColor = dotColor
        self.selectedScale = selectedScale
        self.selectedColor = selectedColor
    }
    
    public var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? selectedColor : dotColor)
                    .scaleEffect(currentIndex == index ? selectedScale : 1.0)
                
                    .frame(width: dotSize, height: dotSize)
                
                    .transition(AnyTransition.opacity.combined(with: .scale))
                
                    .id(index)
            }
        }
    }
}
