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
                    //Homepage Headers
                    TextView(
                        text: self.viewModel.greeting,
                        fontSize: CustomFontSize.largeFontSize,
                        offset: 0,
                        fontType: "Poppins-Bold"
                    )
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .foregroundColor(Color("darkColor"))
                     .padding()
                    
                    TextView(
                        text: "Daily Response",
                        fontSize: CustomFontSize.inputFontSize,
                        offset: 0,
                        fontType: "Poppins-SemiBold"
                    )
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("darkColor"))
                    
                    TextView(
                        text: "Take a moment to reflect and click each box to capture your thoughts...",
                        fontSize: 18,
                        offset: 0,
                        fontType: "Poppins-Regular"
                    )
                    .padding(.top, -7)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("LighterColor"))
                    
                    
                    
                    if (self.viewModel.getTodaysRose() != nil && self.viewModel.getTodaysBud() != nil && self.viewModel.getTodaysThorn() != nil) {
                        
                        NavigationLink(destination: HistoryView(viewModel: viewModel, date: getCurrentDate())){
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 350, height: 100)
                                .foregroundColor(Color("lightCard"))
                                .overlay(
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color("checkGreen"))
                                            .font(.system(size: 43))
                                        Text("Your responses today are complete and recorded.")
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(CustomColor.TextColor)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("veryLightColor"))
                                            .padding([.top, .bottom, .trailing])
                                            .font(.system(size: 24))
                                        
                                    }
                                        .padding(.top)
                                        .padding(.bottom)
                                        .padding(.trailing, -5)
                                        .padding(.leading)
                                )
                            
                        }
                    } else{
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "ROSE")){
                            Cardify(
                                viewModel:self.viewModel,
                                title: "Rose",
                                paragraph: (
                                    /*self.viewModel.getTodaysRose() != nil ? self.viewModel.getTodaysRose()! : */"Highlight a success or something positive today."),
                                image: Image("roseIMG")
                            )
                        }
                        
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "THORN")) {
                            Cardify(
                                viewModel:self.viewModel,
                                title: "Thorn",
                                paragraph: (
                                    /*self.viewModel.getTodaysThorn() != nil ? self.viewModel.getTodaysThorn()!  : */"Describe a challenge you experienced today."),
                                image: Image("thornIMG")
                                //imageName: "roseIMG"
                            )
                        }
                        
                        NavigationLink(destination: InputView(viewModel: viewModel, type: "BUD")) {
                            Cardify(
                                viewModel:self.viewModel,
                                title: "Bud",
                                paragraph: (
                                    /*self.viewModel.getTodaysBud() != nil ? self.viewModel.getTodaysBud()! : */"Explain something that you’re looking forward to."),
                                image: Image("budIMG")
                                //imageName: "roseIMG"
                            )
                        }
                        
                    }
                    
                    
                    HStack{
                        TextView(
                            text: "Your Responses at a Glance",
                            fontSize: CustomFontSize.inputFontSize,
                            offset: 10,
                            fontType: "Poppins-SemiBold"
                        )
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("darkColor"))
                        
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color("veryLightColor"))
                            .padding(.top)
                            .padding(.trailing, 20)
                            .font(.system(size: 24))
                    }
                    
                    WeekGlance(viewModel: viewModel)
                    
                }
            }
        }//end
    }
    
    func getCurrentDate() -> String {
        let location = Locale.current
        let currentDate = Date()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = location
        return dateFormatter.string(from: currentDate)
    }
    
    struct TextView: View {
        let text: String
        let fontSize: CGFloat
        let offset: CGFloat
        let fontType: String
        
        var body: some View {
            Text(text)
                .offset(y: offset)
                .font(Font.custom(fontType, size: fontSize))
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
                case "Rose":
                    return CustomColor.RoseColor
                case "Thorn":
                    return CustomColor.BudColor
                case "Bud":
                    return CustomColor.ThornColor
                default:
                    return CustomColor.TextColor
            }
        }
        

        
        var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 100)
                .foregroundColor(self.cardColor)
                .overlay(
                    HStack{
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0)
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text(self.title)
                                    .font(Font.custom("Poppins-SemiBold", size: CustomFontSize.inputFontSize))
                                    .foregroundColor(Color("darkColor"))
                                /*
                                if self.viewModel.getTodaysRose() != nil {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("checkGreen"))
                                        .font(.system(size: 19))
                                }
                                 */
                            }
                            Text(self.paragraph)
                                .font(Font.custom("Poppins-Regular", size: CustomFontSize.standardFontSize))
                                .foregroundColor(CustomColor.TextColor)
                                .multilineTextAlignment(.leading)
                    
                        }
                        .padding([.top, .bottom, .trailing], 6.0)
                        .offset(x: -10)
                        .foregroundColor(.black)
                        
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("veryLightColor"))
                            .padding([.top, .bottom, .trailing])
                            .font(.system(size: 24))
                        
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
