//
//  TestThreeView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/12/23.
//

import SwiftUI

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
        if viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) != nil{
            VStack(alignment: .leading){
                Text("Rose").font(.system(size: 26))
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteRose(stringDate: dateToString(date: selectDate))
                    }) {
                        if self.viewModel.Getfavorite(with: self.viewModel.savedRoses, stringDate: dateToString(date: selectDate)) == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.mindfulnessBackground)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                        }
                    }
                    Text(viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate))?["message"] ?? "").font(.system(size: 22))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }//end IF
        
        
        //BUD
        if viewModel.getRBT(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) != nil{
            VStack(alignment: .leading){
                Text("Bud").font(.system(size: 26))
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteBud(stringDate: dateToString(date: selectDate))
                    }) {
                        if self.viewModel.Getfavorite(with: self.viewModel.savedBuds, stringDate: dateToString(date: selectDate)) == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.mindfulnessBackground)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                        }
                    }
                    Text(viewModel.getRBT(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate))?["message"] ?? "").font(.system(size: 22))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }//end IF
        
        //THORN
        if viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) != nil{
            VStack(alignment: .leading){
                Text("Thorn").font(.system(size: 26))
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteThorn(stringDate: dateToString(date: selectDate))
                    }) {
                        if self.viewModel.Getfavorite(with: self.viewModel.savedThorns, stringDate: dateToString(date: selectDate)) == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                                .foregroundColor(CustomColor.mindfulnessBackground)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                        }
                    }
                    Text(viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate))?["message"] ?? "").font(.system(size: 22))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }//end IF
        
        //OPEN
        if viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate))?["message"] != nil{
            VStack(alignment: .leading){
                Text("Open Journal").font(.system(size: 26))
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteOpen(stringDate: dateToString(date: selectDate))
                    }) {
                        if viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate))?["favorite"] == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                        }
                    }
                    Text(viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate))?["message"] ?? "").font(.system(size: 22))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }//end IF
        
        //GRAT
        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] != nil{
            VStack(alignment: .leading){
                Text("Gratitude Responses").font(.system(size: 26))
                
                //Input1
                HStack{
                    Button(action: {
                        self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input1")
                    }) {
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["favorite"] == "true" {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 18))
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
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
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
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
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                        }
                    }
                    
                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input3")?["message"] ?? "").font(.system(size: 22))
                }//end HStack
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } //END GRAT
        
        
        
        
    }
}

struct TestThreeView_Previews: PreviewProvider {
    static var previews: some View {
        TestThreeView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
