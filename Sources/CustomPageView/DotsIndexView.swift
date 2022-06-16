// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct DotsIndexView: View {
    
    let currentIndex: Int
    let pageCount: Int
    let maxDots: Int?
    
    let dotSize: CGFloat
    let dotSpacing: CGFloat
    let dotColor: Color

    let selectedScale: CGFloat
    let selectedColor: Color
    
    
    init(currentIndex: Int, pageCount: Int, maxDots: Int? = nil, dotSize: CGFloat = 9, dotSpacing: CGFloat = 12, dotColor: Color = Color.white.opacity(0.6), selectedScale: CGFloat = 1.6, selectedColor: Color = .white) {
        self.currentIndex = currentIndex
        self.pageCount = pageCount
        self.maxDots = maxDots
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.dotColor = dotColor
        self.selectedScale = selectedScale
        self.selectedColor = selectedColor
    }
    
    public var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(pageRange, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? selectedColor : dotColor)
                    .scaleEffect(currentIndex == index ? selectedScale : 1.0)
                
                    .frame(width: dotSize, height: dotSize)
                
                    .transition(AnyTransition.opacity.combined(with: .scale))
                
                    .id(index)
            }
        }
    }
    
    var pageRange: Range<Int> {
        if let maxDots = maxDots {
            let startIndex = currentIndex - (maxDots / 2)
            let endIndex = startIndex + maxDots
            return startIndex..<endIndex
        } else {
            return 0..<pageCount
        }
    }
}
