//
//  TestThreeView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/12/23.
//

import SwiftUI

struct CView: View {
    let title: String
    let message: String
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(Color("mainTextColor"))
            HStack{
                Button(action: {
                    onToggleFavorite()
                }) {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color("HeartRed"))
                    } else {
                        Image(systemName: "heart")
                            .font(.system(size: 18))
                            .foregroundColor(Color("notFilledHeartColor"))
                    }
                }
                Text(message)
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color("responseColor"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 2)
    }
}


struct CalendarView: View {
    @ObservedObject var viewModel: JournalData;
    
    @State private var selectDate = Date()
    @State private var navigate = false
    @State private var isDateAllowed = false
    @State var previousDate: Date = Date()
    
    @State private var showRBT = false
    @State private var showGRAT = false
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate: Date = Date()
    
    func dateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
    }
    
    func showDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        ScrollView {
            VStack{
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("calendarBox"))
                    .frame(width: 350, height: 50)
                    .overlay(
                        HStack(spacing: 15) {
                            ZStack{
                                //Text(dateToString(date: selectDate))
                                Image(systemName: "calendar")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("calendarDate"))
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
                            }//end ZStack
                            
                            Text(showDate(date: selectDate))
                                .foregroundColor(Color("calendarDate"))
                                .font(.custom("Poppins-SemiBold", size: 25))
                        }//end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)
                
                //ROSE
                if let roseData = viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) {
                    //showRBT = true
                    CView(
                        title: "Rose",
                        message: roseData["message"] ?? "",
                        isFavorite: viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: dateToString(date: selectDate)) == "true",
                        onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: dateToString(date: selectDate), path: "Rose", savedType: &viewModel.savedRoses) }
                    )
                }
                
                //BUD
                if let budData = viewModel.getRBT(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) {
                    //showRBT = true
                    CView(
                        title: "Bud",
                        message: budData["message"] ?? "",
                        isFavorite: viewModel.Getfavorite(with: viewModel.savedBuds, stringDate: dateToString(date: selectDate)) == "true",
                        onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: dateToString(date: selectDate), path: "Bud", savedType: &viewModel.savedBuds) }
                    )
                }
                
                //THORN
                if let thornData = viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) {
                    //showRBT = true
                    CView(
                        title: "Thorn",
                        message: thornData["message"] ?? "",
                        isFavorite: viewModel.Getfavorite(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) == "true",
                        onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: dateToString(date: selectDate), path: "Thorn", savedType: &viewModel.savedThorns) }
                    )
                }
                
                
                //DIVIDER
                if let _ = viewModel.getRBT(with: viewModel.savedThorns, stringDate: dateToString(date: selectDate)) {
                    VStack(spacing: 0) {
                        Divider().background(Color("lineColor")).frame(height: 10)
                        //height does nothing
                    }
                }
                
                
                //GRAT
                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] != nil{
                    VStack(alignment: .leading){
                        Text("Gratitude Responses")
                            .font(.custom("Poppins-Medium", size: 22))
                            .foregroundColor(Color("mainTextColor"))
                        
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
                                        .foregroundColor(Color("HeartRed"))
                                } else {
                                    Image(systemName: "heart")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("notFilledHeartColor"))
                                }
                            }
                            
                            Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] ?? "")
                                    .font(.custom("Poppins-Regular", size: 20))
                                    .foregroundColor(Color("responseColor"))
                        }//end HStack
                        .padding(.bottom, 1)
                        
                        //Input2
                        HStack{
                            Button(action: {
                                self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input2")
                            }) {
                                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input2")?["favorite"] == "true" {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("HeartRed"))
                                } else {
                                    Image(systemName: "heart")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("notFilledHeartColor"))
                                }
                            }
                            
                            Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input2")?["message"] ?? "")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(Color("responseColor"))
                        }//end HStack
                        .padding(.bottom, 1)
                        
                        //Input3
                        HStack{
                            Button(action: {
                                self.viewModel.addFavoriteGrat(stringDate: dateToString(date: selectDate), whichInput: "Input3")
                            }) {
                                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input3")?["favorite"] == "true" {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("HeartRed"))
                                } else {
                                    Image(systemName: "heart")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("notFilledHeartColor"))
                                }
                            }
                            
                            Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input3")?["message"] ?? "")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(Color("responseColor"))
                        }//end HStack
                        .padding(.bottom, 1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } //END GRAT
                
                
                //DIVIDER
                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: selectDate), whichInput: "Input1")?["message"] != nil{
                    VStack(spacing: 0) {
                        Divider().background(Color("lineColor")).frame(height: 10)
                        //height does nothing
                    }
                }
                
                //OPEN
                if let OpenData = viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate)) {
                    CView(
                        title: "Open Journal",
                        message: OpenData["message"] ?? "",
                        isFavorite: viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: selectDate))?["favorite"] == "true",
                        onToggleFavorite: { viewModel.addFavoriteOpen(stringDate: dateToString(date: selectDate)) }
                    )
                }
                Spacer()
            }//end VStack
        }//end ScrollView
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .background(Color("NEWbackground"))
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
