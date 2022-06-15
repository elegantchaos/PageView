import SwiftUI


public struct CustomPageView<SelectionValue, Content, Index>: View where SelectionValue: Hashable, Content: View, Index: View  {
    @Binding var selection: SelectionValue
    @ViewBuilder var content: () -> Content
    @ViewBuilder var index: () -> Index
    
    public var body: some View {
        TabView(selection: $selection.animation()) {
            content()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
            Fancy3DotsIndexView(numberOfPages: colors.count, currentIndex: currentIndex)
        }
    }
}

struct CustomPageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCustomPageView()
    }
}

struct Fancy3DotsIndexView: View {
  
  // MARK: - Public Properties
  
  let numberOfPages: Int
  let currentIndex: Int
  
  
  // MARK: - Drawing Constants
  
  private let circleSize: CGFloat = 16
  private let circleSpacing: CGFloat = 12
  
  private let primaryColor = Color.white
  private let secondaryColor = Color.white.opacity(0.6)
  
  private let smallScale: CGFloat = 0.6
  
  
  // MARK: - Body
  
  var body: some View {
    HStack(spacing: circleSpacing) {
      ForEach(0..<numberOfPages) { index in // 1
        if shouldShowIndex(index) {
          Circle()
            .fill(currentIndex == index ? primaryColor : secondaryColor) // 2
            .scaleEffect(currentIndex == index ? 1 : smallScale)
            
            .frame(width: circleSize, height: circleSize)
       
            .transition(AnyTransition.opacity.combined(with: .scale)) // 3
            
            .id(index) // 4
        }
      }
    }
  }
  
  
  // MARK: - Private Methods
  
  func shouldShowIndex(_ index: Int) -> Bool {
    ((currentIndex - 1)...(currentIndex + 1)).contains(index)
  }
}
