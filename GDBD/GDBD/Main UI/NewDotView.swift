//
//  NewDotView.swift
//  GDBD
//
//  Created by Samuel Wong on 18/8/2022.
//

import SwiftUI

struct NewDotView: View {
    @State var isShowingNewGoodDot = false
    @State var isShowingNewBadDot = false
    
    var body: some View {
        HStack(spacing: 40) {
            Button {
                isShowingNewGoodDot = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Good Dot")
                }
            }.sheet(isPresented: $isShowingNewGoodDot) {
                CreateDotView(isGood: true, onDismiss: {
                    isShowingNewGoodDot = false
                })
                    .presentationDetents([.height(275)])
            }
            
            Button {
                isShowingNewBadDot = true
            } label: {
                HStack {
                    Image(systemName: "minus.circle")
                    Text("Bad Dot")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
    }
}

struct NewDotView_Previews: PreviewProvider {
    static var previews: some View {
        NewDotView()
    }
}

