//
//  IntroPopupView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-13.
//

import SwiftUI

/** The welcome popup shown to new users */
struct IntroPopupView: View {
    @Environment(\.presentationMode) private var presentation
    @Binding var show: Bool
    @Binding var sheet: Int?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("logo").resizable().scaledToFit().frame(width: 80, height: 80).padding(.top, 25)
            Text("Welcome to Cards!").font(appTitleFont)
            Text("With Cards, you can easily automate your day and customize your daily brief. Let's begin by creating your first card.").padding(.bottom, 20)
            Divider()
            Button(action: {
                sheet = 0 // Present `AddCardView`
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    show.toggle() // Dismiss this popup
                }
            }) {
                HStack {
                    Spacer()
                    Text("Start").font(appTitleFont).foregroundColor(mainColor).padding(.top, 3)
                    Spacer()
                }
            }
        }.padding(.vertical, 15).padding(.horizontal, 25)
        .frame(width: UIScreen.screenWidth-50)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(12)
    }
    
}

/** Handles the logic of presenting/dismissing the intro popup view*/
struct IntroPopupViewLogic: View {
    @Binding var show: Bool
    @Binding var sheet: Int?
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Spacer()
                    IntroPopupView(show: $show, sheet: $sheet).offset(y: self.show ? CGFloat(0) : UIScreen.screenHeight*1.4)
                    Spacer()
                }
                Spacer()
            }
        }.background((self.show ? Color.black.opacity(0.35) : Color.clear)
                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                                self.show.toggle()
//                        }
                        )
        .edgesIgnoringSafeArea(.bottom)
        .animation(.spring())
    }
}
