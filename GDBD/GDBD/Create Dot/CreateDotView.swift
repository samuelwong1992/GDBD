//
//  CreateDotView.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import SwiftUI

struct CreateDotView: View {
    
    init(isGood: Bool, onDismiss: @escaping (() -> Void)) {
        self.onDismiss = onDismiss
        self.modelStore = CreateDotViewStore(isGood: isGood, storageService: DotCoreDataService())
    }
    
    @ObservedObject private var modelStore: CreateDotViewStore
    
    @State private var succeeded: Bool = false
    @State private var successScaleFactor: CGFloat = 0.0
    
    func animateSucceeded() {
        self.succeeded = true
        withAnimation(Animation.easeInOut(duration: 0.4)) {
            successScaleFactor = 1.2
        }
        withAnimation(Animation.easeInOut(duration: 0.2).delay(0.4)) {
            successScaleFactor = 0.8
        }
        withAnimation(Animation.easeInOut(duration: 0.2).delay(0.6)) {
            successScaleFactor = 1.0
        }
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { _ in
            self.onDismiss()
        }
    }
    
    var onDismiss: (() -> Void)
    
    var body: some View {
        ZStack {
            if(!succeeded) {
                VStack {
                    Text("Adding a \(modelStore.isGood ? "Good" : "Bad") Dot!")
                        .font(.title)
                    
                    DatePicker(
                        "When",
                        selection: $modelStore.date,
                        in: ...Date(),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    
                    TitledTextField(text: $modelStore.text, placeholder: "Description", placeholderExtras: "(Optional)")
                    
                    HStack {
                        SecondaryButton(title: "Cancel") {
                            onDismiss()
                        }
                        
                        PrimaryButton(title: "Submit") {
                            modelStore.createDot(completion: {(_) -> Void in
                                animateSucceeded()
                            })
                        }
                    }
                }
                .foregroundColor(.primary)
                .padding()
            }
            VStack {
                Circle()
                    .scale(successScaleFactor)
                    .fill(Color.blue)
                    .frame(height: 90)
                    .overlay {
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
            }
        }
        .alert("Error", isPresented: $modelStore.showAlert) {
            Button("OK") {
                modelStore.dismissError()
            }
        } message: {
            Text(modelStore.error?.localizedDescription ?? "")
        }
    }
}

struct CreateDotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateDotView(isGood: true, onDismiss: {})
            
            CreateDotView(isGood: true, onDismiss: {}).preferredColorScheme(.dark)
        }
    }
}
