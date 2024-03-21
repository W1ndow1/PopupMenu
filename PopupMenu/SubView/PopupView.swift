//
//  PopupView.swift
//  PopupMenu
//
//  Created by window1 on 3/8/24.
//

import Foundation
import SwiftUI

struct PopupView: View {
    
    let config: SheetManager.Config
    let didClose: () -> Void
    
    @State private var isDragging = false
    
    var body: some View {
        VStack(spacing: .zero) {
            icon
            title
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 40)
        .multilineTextAlignment(.center)
        .background(background)
        .overlay(alignment: .topTrailing) {
            closeButton
        }
        .transition(.move(edge: .bottom))
        .gesture(drag)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged {
                _ in self.isDragging = true
            }
            .onEnded {
                _ in self.isDragging = false
                didClose()
            }
    }
}

#Preview {
    PopupView(config: .init(systemName: "xmark",
                            title: "Text Here",
                            content: """
                            비 정상적인 접근 입니다. (ECI00001)
                            문의사항이 있으신 분들은 아래 연락처로 문의바랍니다.
                            000-0000-0000
                            """)) {}
        .padding()
        .background(.blue)
        .previewLayout(.sizeThatFits)
}

private extension PopupView {
    
    var closeButton: some View {
        Button {
            withAnimation {
                didClose()
            }
        } label: {
            Image(systemName: "xmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 35,
                              weight: .bold,
                              design: .rounded))
                .foregroundStyle(.gray.opacity(0.4))
                .padding(8)
        }
    }
    
    var background: some View {
        RoundedCorners(color: .white,
                       tl: 10,
                       tr: 10,
                       bl: 10,
                       br: 10)
        .shadow(color: .black.opacity(0.2),
                radius: 3)
    }
    
    var icon: some View {
        Image(systemName: config.systemName)
            .symbolVariant(.circle.fill)
            .font(.system(size: 50,
                          weight: .bold,
                          design: .rounded))
            .foregroundStyle(.blue)
    }
    
    var title: some View {
        Text(config.title)
            .font(.system(size: 30,
                          weight: .bold,
                          design: .default))
            .foregroundStyle(.black)
    }
    
    var content: some View {
        Text(config.content)
        .font(.callout)
        .foregroundStyle(.black)
    }
}

//MARK: - RoundedCorner

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}
