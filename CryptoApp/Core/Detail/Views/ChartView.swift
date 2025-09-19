//
//  ChartView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 17/09/25.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private  let middleY: Double
    private  let lineColor: Color
    private  let startDate: Date
    private  let endDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        middleY = (maxY + minY) / 2
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endDate = Date(date: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            Chart
                .frame(height: 200)
                .background(
                    ChartBackground
                )
                .overlay(alignment: .leading) {
                    ChartYAxis
                        .padding(.horizontal, 4)
                }
            
            ChartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: CoinModel.preview)
}


extension ChartView {
    
    private var Chart: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0), radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 30)
        }
    }
    
    private var ChartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var ChartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(middleY.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var ChartDateLabels: some View {
        HStack {
            Text(startDate.asShortString())
            Spacer()
            Text(endDate.asShortString())
        }
    }
}
