//
//  TempHomeView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct TempHomeView: View {

    @State private var showCreateGalaxy = false
    @State private var showWritePledge = false
    @State private var showWriteRecord = false

    var body: some View {
        VStack(spacing: 20) {

            Button("🌌 은하 생성") {
                showCreateGalaxy = true
            }

            Button("✍️ 다짐 생성") {
                showWritePledge = true
            }

            Button("📝 기록 생성") {
                showWriteRecord = true
            }
        }
//        .fullScreenCover(isPresented: $showCreateGalaxy) {
//            CreateGalaxyView()
//        }
        .fullScreenCover(isPresented: $showWritePledge) {
            NavigationStack {
                WritePledgeView(
                    onFinish: {
                        showWritePledge = false
                    }
                )
            }
        }
        .fullScreenCover(isPresented: $showWriteRecord) {
            NavigationStack {
                WriteRecordView(
                    onFinish: {
                        showWriteRecord = false
                    }
                )
            }
        }
    }
}


#Preview {
    TempHomeView()
}
