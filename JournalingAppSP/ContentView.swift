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
                        fontSize: CustomFontSize.standardFontSize,
                        offset: 0
                    )
                    
                    OffsetTextView(
                        text: "Rose, Bud, Thorn",
                        fontSize: CustomFontSize.extraLargeFont,
                        offset: 0
                    )
                    
                    OffsetTextView(
                        text: "A Mindful Way to Reflect",
                        fontSize: CustomFontSize.standardFontSize,
                        offset: 0
                    )
                    
                    
                    // Scroll view of rose, bud, thorn
                    ScrollView(.vertical) {
                        VStack() {
                            NavigationLink(destination: Rose(viewModel: self.viewModel)) {
                                Cardify(
                                    viewModel:self.viewModel,
                                    title: "ROSE",
                                    paragraph: (
                                        self.viewModel.roseInput != "" ? self.viewModel.roseInput : "A highlight, success, small win, or something positive that happened today.")
                                )
                            }
                            NavigationLink(destination: Bud(viewModel: self.viewModel)) {
                                Cardify(
                                    viewModel:self.viewModel,
                                    title: "BUD",
                                    paragraph: (self.viewModel.budInput != "" ? self.viewModel.budInput : "A challenge you experienced or something you can use more support with.")
                                )
                            }
                            NavigationLink(destination: Thorn(viewModel: self.viewModel)) {
                                Cardify(
                                    viewModel:self.viewModel,
                                    title: "THORN",
                                    paragraph: (self.viewModel.thornInput != "" ? self.viewModel.thornInput : "New ideas that have blossomed or something you are looking forward to knowing more about or experiencing.")
                                )
                            }
                        }
                }
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
        let viewModel: JournalData
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
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 200)
                .foregroundColor(self.cardColor)
                .overlay(
                        VStack {
                            Text(self.title)
                                .font(Font.custom("Poppins-Medium", size: CustomFontSize.largeFontSize))
                            Text(self.paragraph)
                                .foregroundColor(CustomColor.TextColor)
                                .offset(y: 10)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .font(Font.custom("Poppins-Medium", size: CustomFontSize.standardFontSize))
                        .padding()
                )       .padding(.vertical, 8.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView(viewModel: JournalData())
    }
}
