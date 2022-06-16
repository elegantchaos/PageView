# PageView

A slightly more flexible SwiftUI PageView.

This uses TabView with a `.page` tabViewStyle to implement the basic paging behaviour, but it accepts a second closure should be a view builder defining the index view to use instead of the default dots.

It also allows you to specify the alignment and padding of the index view - so you can inset it more than usual or move it to the top or to one side.

## Usage:

```swift

        PageView(selection: $selection, indexAlignment: .bottomLeading, indexPadding: 40.0) {
            ForEach(items) { item in
                Text(item)
                    .tag(item)
            }
        } index: {
            DotsIndexView(currentIndex: selection)
        }
        
```
