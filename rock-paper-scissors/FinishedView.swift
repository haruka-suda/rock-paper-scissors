//
//  FinishedView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/14.
//

import SwiftUI

struct FinishedView: View {
    @EnvironmentObject var appState: AppState
    @Binding var screenMode: ScreenMode
    @State private var fadeOut = false
    @State private var showResult = false
    

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            if !showResult{
                Text("finished_label".localized)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("primaryBlue"))
                    .scaleEffect(fadeOut ? 0.8 : 1.0)
                    .opacity(fadeOut ? 0 : 1)
                    .animation(.easeOut(duration: 2.5), value: fadeOut)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fadeOut = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showResult = true
                screenMode = .result
            }
        }
    }
}

