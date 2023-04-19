//
//  TestThreeView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/12/23.
//

import SwiftUI

struct CalView: View {
    let title: String
    let message: String
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.system(size: 26))
            HStack{
                Button(action: {
                    onToggleFavorite()
                }) {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 18))
                            .foregroundColor(CustomColor.heartRed)
                    } else {
                        Image(systemName: "heart")
                            .font(.system(size: 18))
                            .foregroundColor(Color.black)
                    }
                }
                Text(message).font(.system(size: 22))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct TestThreeView: View {
    @ObservedObject var viewModel: JournalData;
    
    @State private var selectDate = Date()
    @State private var navigate = false
    @State private var isDateAllowed = false
    @State var previousDate: Date = Date()
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate: Date = Date()
    
    func dateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // the way the date is formatted in HistoryView
            return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        
        HStack{
            ZStack{
                //Text(dateToString(date: selectDate))
                Image(systemName: "calendar")
                    .font(.system(size: 30))
                //.foregroundColor(Color("veryLightColor"))
                    .overlay {
                        DatePicker(
                            "",
                            selection: $selectDate,
                            in: startingDate...endingDate,
                            displayedComponents: [.date]
                        )
                        .blendMode(.destinationOver)
                        .onChange(of: selectDate) { newValue in
                            
                            //if they haven't made any type of response for that day
                            if viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) == nil
                                && viewModel.getRBT(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) == nil
                                && viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) == nil {
                                //if they select a date that they don't have responses for
                                selectDate = previousDate
                            } else{
                                previousDate = selectDate
                            }
                            
                        }
                    }
            }
            
            Text(dateToString(date: selectDate)).font(.system(size: 30))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
        //ROSE
        if let roseData = viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) {
                CalView(
                    title: "Rose",
                    message: roseData["message"] ?? "",
                    isFavorite: viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) == "true",
                    onToggleFavorite: { viewModel.addFavoriteRose(stringDate: dateToString(date: selectDate)) }
                )
            }
        
        //BUD
        if let budData = viewModel.getRBT(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) {
            CalView(
                title: "Bud",
                message: budData["message"] ?? "",
                isFavorite: viewModel.Getfavorite(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) == "true",
                onToggleFavorite: { viewModel.addFavoriteBud(stringDate: dateToString(date: selectDate)) }
            )
        }
        
        //THORN
        if let thornData = viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) {
            CalView(
                title: "Thorn",
                message: thornData["message"] ?? "",
                isFavorite: viewModel.Getfavorite(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) == "true",
                onToggleFavorite: { viewModel.addFavoriteThorn(stringDate: dateToString(date: selectDate)) }
            )
        }
        
        //GRAT
        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] != nil{
            VStack(alignment: .leading){
                Text("Gratitude Responses").font(.system(size: 26))
                
                //Input1
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input1")
                        //HERE
                        //self.viewModel.getWeekRBT(array: viewModel.savedRoses)
                    }) {
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["favorite"] == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.heartRed)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] ?? "").font(.system(size: 22))
                }//end HStack
                
                //Input2
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input2")
                    }) {
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input2")?["favorite"] == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.heartRed)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input2")?["message"] ?? "").font(.system(size: 22))
                }//end HStack
                
                //Input3
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input3")
                    }) {
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input3")?["favorite"] == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.heartRed)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input3")?["message"] ?? "").font(.system(size: 22))
                }//end HStack
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } //END GRAT
        
        //OPEN
        if let OpenData = viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate)) {
            CalView(
                title: "Open Journal",
                message: OpenData["message"] ?? "",
                isFavorite: viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate))?["favorite"] == "true",
                onToggleFavorite: { viewModel.addFavoriteOpen(stringDate: dateToString(date: selectDate)) }
            )
        }
        
        
        
    }
}

struct TestThreeView_Previews: PreviewProvider {
    static var previews: some View {
        TestThreeView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
