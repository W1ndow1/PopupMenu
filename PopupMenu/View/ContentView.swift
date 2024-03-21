//
//  ContentView.swift
//  PopupMenu
//
//  Created by window1 on 2/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var sheetManager: SheetManager
    
    var body: some View {
        ZStack {
            Color
                .pink.opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    withAnimation(.bouncy) {
                        sheetManager.present(with: .init(systemName: "info", title: "Text Here", content: "123123123"))
                    }
                } label: {
                    Text("Show Sheet")
                        .foregroundStyle(Color.white)
                }
                .padding(12)
                .background(.tint)
                .clipShape(Capsule())
                .font(.system(size: 20,
                              weight: .bold,
                              design: .rounded))
                
                Button {
                    withAnimation(.spring()) {
                        sheetManager.present(with: .init(systemName: "scribble.variable", title: "입금을 실행 하시겠습니까?", content: """
                            언론·출판에 대한 허가나 검열과 집회·결사에 대한 허가는 인정되지 아니한다. 민주평화통일자문회의의 조직·직무범위 기타 필요한 사항은 법률로 정한다.
                            이 헌법에 의한 최초의 대통령의 임기는 이 헌법시행일로부터 개시한다. 국가안전보장회의는 대통령이 주재한다. 외국인은 국제법과 조약이 정하는 바에 의하여 그 지위가 보장된다.
                            """))
                    }
                } label: {
                    Text("Show Sheet")
                        .foregroundStyle(Color.white)
                }
                .padding(12)
                .background(.tint)
                .clipShape(Capsule())
                .font(.system(size: 20,
                              weight: .bold,
                              design: .rounded))
                
            }
        }
        .popup(with: sheetManager)
    }
}


#Preview {
    ContentView()
        .environmentObject(SheetManager())
}
