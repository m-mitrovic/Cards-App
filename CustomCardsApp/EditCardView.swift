//
//  EditCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-09.
//

import SwiftUI

struct EditCardView: View {
    @Binding var cards: [Card]
    @State var editMode = EditMode.active
    
    var body: some View {
        NavigationView {
            ZStack {
                ClosureIndicator()
                VStack(alignment: .leading) {
                    Text("Edit Cards").font(appTitleFont).padding(.leading, 20)
                    NavigationLink(destination: AddCardView(cards: $cards, index: 0),
                                   label: {
                                    Text("Create A Card")
                                   }).buttonStyle(MultiColoredLargeButtonStyle()).padding(.leading, 30).padding(.vertical, 8)
                    
                    List {
                        ForEach(cards.indices, id: \.self) { i in
                            //Text(cards[i].cardTypeName)
                            CardView(card: cards[i]).background(Color.white.opacity(0.12)).cornerRadius(12)
                                .frame(width: cardWidth, height: cardWidth/1.8)
                                .scaleEffect(0.6).frame(width: cardWidth*0.6, height: cardWidth/1.8*0.6)
                                .padding(.vertical, 5)
                        }.onDelete(perform: onDelete).onMove(perform: onMove)
                    }.environment(\.editMode, $editMode)
                }.padding(.top, 45)
            }
            .navigationBarHidden(true)
            .onDisappear() {
                print("Saving data")
                Save.saveCards(cards) {
                    //
                }
            }
        }
    }
    
    func onDelete(offsets: IndexSet) {
       var array = cards
       array.remove(atOffsets: offsets)
       cards = array
   }
   
    func onMove(source: IndexSet, destination: Int) {
       var array = cards
        array.move(fromOffsets: source, toOffset: destination)
       cards = array
   }
}


struct ClosureIndicator: View {
    var body: some View {
        VStack {
            Capsule().fill(Color(UIColor.systemGray5)).frame(width: 65, height: 10).padding(.vertical, 11)
            Spacer()
        }
    }
}
