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
            ScrollView(.vertical) {
                VStack {
                    HStack{
                        //Homepage Headers
                        OffsetTextView(
                            text: self.viewModel.greeting,
                            fontSize: CustomFontSize.largeFontSize,
                            offset: 0
                            
                        )
                        Spacer()
                        
                        NavigationLink(destination: WeekGlance(viewModel: self.viewModel)) {
                            Image(systemName: "calendar")
                                .font(.system(size: 30))
                        }
                            
                    }
                    .padding()
                    
                    VStack {
                        HStack{
                            OffsetTextView(
                                text: "Take a moment to reflect and click each box to capture your thoughts...",
                                fontSize: 16,
                                offset: 20
                            )
                            .foregroundColor(CustomColor.TextColor)
                            Spacer()
                        }.padding()
                        
                        // Scroll view of rose, bud, thorn
                        /** Testing the new input view */
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "ROSE")){
                            Cardify(
                                viewModel:self.viewModel,
                                title: "ROSE",
                                paragraph: (
                                    self.viewModel.getTodaysRose() != nil ? self.viewModel.getTodaysRose()! : "Highlight a success, small win, or something positive that happened today or that you are planning for today."),
                                image: Image("roseIMG")
                                //imageName: "roseIMG"
                            )
                        }
                        .navigationBarBackButtonHidden(true)
                        
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "THORN")) {
                            Cardify(
                                viewModel:self.viewModel,
                                title: "THORN",
                                paragraph: (
                                    self.viewModel.getTodaysThorn() != nil ? self.viewModel.getTodaysThorn()!  : "A challenge you experienced or something you can use more support with."),
                                image: Image("thornIMG")
                                //imageName: "roseIMG"
                            )
                        }
                        
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "BUD")) {
                            Cardify(
                                viewModel:self.viewModel,
                                title: "BUD",
                                paragraph: (
                                    self.viewModel.getTodaysBud() != nil ? self.viewModel.getTodaysBud()! : "New ideas that have blossomed or something you are looking forward to experiencing."),
                                image: Image("budIMG")
                                //imageName: "roseIMG"
                            )
                        }
                        
                    }.offset(y: -20)
                    
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
        let image: Image
        //let imageName: String
        
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
                    HStack{
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
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0)
                    }
                )
                .padding(.vertical, 8.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView(viewModel: JournalData())
    }
}
