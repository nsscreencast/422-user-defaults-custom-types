import SwiftUI

struct BarAnchorPreference: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil

    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}

extension View {
    func printing<A>(_ value: A) -> Self {
        print(value)
        return self
    }
}

struct GraphView: View {

    let data: [CGFloat] = [0.25, 0.85, 0.72, 0.12, 0.34]

    @State var selectedBarIndex = 0

    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom) {
                ForEach(self.data.indices) { index in
                    Rectangle()
                        .fill(index == self.selectedBarIndex ? Color.blue : Color.red)
                        .frame(height: self.data[index] * proxy.size.height)
                        .onTapGesture {
                            withAnimation {
                                self.selectedBarIndex = index
                            }
                    }
                    .anchorPreference(key: BarAnchorPreference.self, value: .bounds, transform: { anchor in
                        index == self.selectedBarIndex ? anchor : nil
                    })
                }
            }
            .background(Color.black.opacity(0.05))
            .overlayPreferenceValue(BarAnchorPreference.self) { anchor in
                GeometryReader { proxy in
                    ZStack(alignment: .topLeading) {
                        Color.clear
                        self.createIndicator(barBounds: proxy[anchor!])
                    }
                }
            }
        }
    }

    func createIndicator(barBounds: CGRect) -> some View {
        let size = CGSize(width: 30, height: 20)
        return Indicator()
            .fill(Color.blue)
            .frame(width: size.width, height: size.height)
            .offset(x: (barBounds.width-size.width)/2 + barBounds.minX,
                    y: barBounds.minY - size.height)
            .printing(barBounds)
    }

    struct Indicator: Shape {
        func path(in rect: CGRect) -> Path {
            Path { p in
                p.move(to: rect.origin)
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                p.addLine(to: rect.origin)
            }
        }
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView()
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
