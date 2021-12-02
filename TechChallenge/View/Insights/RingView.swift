//
//  RingView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

fileprivate typealias Category = TransactionModel.Category

struct RingView: View {
    @StateObject var viewmodel:TransactionsViewModel

    private func ratio(for categoryIndex: Int) -> Double {
        guard let category = Category[categoryIndex] else { return 0.0 }
        return (viewmodel.categoryTotalMap[category] ?? 0.0) / viewmodel.transactionsTotal
    }
    
    private func offset(for categoryIndex: Int) -> Double {
        (0..<categoryIndex).reduce(into: 0.0) { $0 += ratio(for: $1) }
    }

    private func gradient(for categoryIndex: Int) -> AngularGradient {
        let color = Category[categoryIndex]?.color ?? .black
        return AngularGradient(
            gradient: Gradient(colors: [color.unsaturated, color]),
            center: .center,
            startAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: 0
            ),
            endAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: ratio(for: categoryIndex)
            )
        )
    }
    
    private func percentageText(for categoryIndex: Int) -> String {
        "\((ratio(for: categoryIndex) * 100).formatted(hasDecimals: false))%"
    }
    
    var body: some View {
        ZStack {
            ForEach(Category.allCases.indices) { categoryIndex in
                let categoryOffset = offset(for: categoryIndex)
                let categoryratio = ratio(for: categoryIndex)
                
                if categoryratio > 0.0 {
                    PartialCircleShape(
                        offset: categoryOffset,
                        ratio: categoryratio
                    )
                    .stroke(
                        gradient(for: categoryIndex),
                        style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                    )
                    .overlay(
                        PercentageText(
                            offset: categoryOffset,
                            ratio: categoryratio,
                            text: percentageText(for: categoryIndex)
                        )
                    )
                }
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double
        
        func path(in rect: CGRect) -> Path {
            Path(offset: offset, ratio: ratio, in: rect)
        }
    }
    
    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String
        
        private func position(for geometry: GeometryProxy) -> CGPoint {
            let rect = geometry.frame(in: .local)
            let path = Path(offset: offset, ratio: ratio / 2.0, in: rect)
            return path.currentPoint ?? .zero
        }
        
        var body: some View {
            GeometryReader { geometry in
                Text(text)
                    .percentage()
                    .position(position(for: geometry))
            }
        }
    }
}

#if DEBUG
struct RingView_Previews: PreviewProvider {
    static var sampleRing: some View {
        ZStack {
            RingView.PartialCircleShape(offset: 0.0, ratio: 0.15)
                .stroke(
                    Color.red,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
            
            RingView.PartialCircleShape(offset: 0.15, ratio: 0.5)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
                
            RingView.PartialCircleShape(offset: 0.65, ratio: 0.35)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
        }
    }
    
    static var previews: some View {
        VStack {
            sampleRing
                .scaledToFit()
            
            RingView(viewmodel: TransactionsViewModel())
                .scaledToFit()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
