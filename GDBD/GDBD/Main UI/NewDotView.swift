//
//  NewDotView.swift
//  GDBD
//
//  Created by Samuel Wong on 18/8/2022.
//

import SwiftUI

struct NewDotView: View {
    var body: some View {
        HStack(spacing: 40) {
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Good Dot")
                }
            }
            
            
            Button {
                
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

