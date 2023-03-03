//
//  ContentView.swift
//  Journaling App
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI
//poppins font

struct ContentView: View {
    @ObservedObject var viewModel: JournalData;
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack {
                //Homepage Headers
                OffsetTextView(
                    text: getCurrentDate(),
                    fontSize: CustomFontSize.smallFontSize,
                    offset: -40
                )
                
                OffsetTextView(
                    text: "Rose, Bud, Thorn",
                    fontSize: CustomFontSize.extraLargeFont,
                    offset: -30
                )
                
                OffsetTextView(
                    text: "A Mindful Way to Reflect",
                    fontSize: CustomFontSize.standardFontSize,
                    offset: -20
                )
                

                // Scroll view of rose, bud, thorn
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: Rose()) {
                            Cardify(
                                title: "ROSE",
                                paragraph: "A highlight, success, small win, or something positive that happened today."
                            )
                        }
                        NavigationLink(destination: Bud()) {
                            Cardify(
                                title: "BUD",
                                paragraph: "A challenge you experienced or something you can use more support with."
                            )
                        }
                        NavigationLink(destination: Thorn()) {
                            Cardify(
                                title: "THORN",
                                paragraph: "New ideas that have blossomed or something you are looking forward to knowing more about or experiencing."
                            )
                        }
                    }
                }
                .padding(20)
            }
        }
    }
    
    func getCurrentDate() -> String {
        let location = Locale.current
        let currentDate = Date()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = location
        return dateFormatter.string(from: currentDate)
    }
    
    struct OffsetTextView: View {
        let text: String
        let fontSize: CGFloat
        let offset: CGFloat
        
        var body: some View {
            Text(text)
                .offset(y: offset)
                .font(Font.custom("Poppins-Medium", size: fontSize))
        }
    }
    
    // A View that allows you to easily reuse code to turn values into a "card"
    struct Cardify: View {
        let title: String
        let paragraph: String
        
        var cardColor: Color {
            switch(title) {
                case "ROSE":
                    return CustomColor.RoseColor
                case "BUD":
                    return CustomColor.BudColor
                case "THORN":
                    return CustomColor.ThornColor
                default:
                    return CustomColor.TextColor
            }
        }
        
        var body: some View {
            
            Rectangle()
                .frame(width: 300, height: 500)
                .foregroundColor(self.cardColor)
                .cornerRadius(10)
                .overlay(
                        VStack {
                            Text(self.title)
                            Text(self.paragraph)
                                .foregroundColor(CustomColor.TextColor)
                                .offset(y: 40)
                            Spacer()
                        }
                        .offset(y: 30)
                        .padding()
                        .foregroundColor(.black)
                        .font(Font.custom("Poppins-Medium", size: CustomFontSize.largeFontSize))
                        
                )
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView(viewModel: JournalData())
    }
}
