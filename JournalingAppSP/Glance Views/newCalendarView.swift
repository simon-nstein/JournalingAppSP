//
//  TestFiveView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/19/23.
//

class SharedData: ObservableObject {
    @Published var sharedVariable: Bool = false
    @Published var selectedDate: String = "2023-05-01"
}


import SwiftUI

struct newCalendarView: View {
    @ObservedObject var viewModel: JournalData;
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        
        ScrollView{
        
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("calendarBox"))
                    .frame(width: 350, height: 50)
                    .overlay(
                        HStack(spacing: 15) {
                            ZStack{
                                
                                Button(action: {
                                    sharedData.sharedVariable.toggle()
                                }) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color("calendarDate"))
                                }//end BUTTON
                                
                                
                                
                            }//end ZStack
                            
                            //Text(showDate(date: selectDate))
                            Text(sharedData.selectedDate)
                                .foregroundColor(Color("calendarDate"))
                                .font(.custom("Poppins-SemiBold", size: 25))
                        }//end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)
                
                
                ZStack{
                    if sharedData.sharedVariable {
                        CustomCalendar(viewModel: self.viewModel)
                            .offset(y: -80)
                            .zIndex(1)
                    }//END IF
                    
                    VStack{
                        //ROSE
                        if let roseData = viewModel.getRBT(with: viewModel.savedRoses, stringDate: sharedData.selectedDate) {
                            //showRBT = true
                            CView(
                                title: "Rose",
                                message: roseData["message"] ?? "",
                                isFavorite: viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: sharedData.selectedDate) == "true",
                                onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: sharedData.selectedDate, path: "Rose", savedType: &viewModel.savedRoses) }
                            )
                        }
                        
                        //BUD
                        if let budData = viewModel.getRBT(with: viewModel.savedBuds, stringDate: sharedData.selectedDate) {
                            //showRBT = true
                            CView(
                                title: "Bud",
                                message: budData["message"] ?? "",
                                isFavorite: viewModel.Getfavorite(with: viewModel.savedBuds, stringDate: sharedData.selectedDate) == "true",
                                onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: sharedData.selectedDate, path: "Bud", savedType: &viewModel.savedBuds) }
                            )
                        }
                        
                        //THORN
                        if let thornData = viewModel.getRBT(with: viewModel.savedThorns, stringDate: sharedData.selectedDate) {
                            //showRBT = true
                            CView(
                                title: "Thorn",
                                message: thornData["message"] ?? "",
                                isFavorite: viewModel.Getfavorite(with: viewModel.savedThorns, stringDate: sharedData.selectedDate) == "true",
                                onToggleFavorite: { viewModel.addFavoriteRBT(stringDate: sharedData.selectedDate, path: "Thorn", savedType: &viewModel.savedThorns) }
                            )
                        }
                        
                        
                        //DIVIDER
                        if let _ = viewModel.getRBT(with: viewModel.savedThorns, stringDate: sharedData.selectedDate) {
                            VStack(spacing: 0) {
                                Divider().background(Color("lineColor")).frame(height: 10)
                                //height does nothing
                            }
                        }
                        
                        
                        //GRAT
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input1")?["message"] != nil{
                            VStack(alignment: .leading){
                                Text("Gratitude Responses")
                                    .font(.custom("Poppins-Medium", size: 22))
                                    .foregroundColor(Color("mainTextColor"))
                                
                                //Input1
                                HStack{
                                    Button(action: {
                                        self.viewModel.addFavoriteGrat(stringDate: sharedData.selectedDate, whichInput: "Input1")
                                        //HERE
                                        //self.viewModel.getWeekRBT(array: viewModel.savedRoses)
                                    }) {
                                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input1")?["favorite"] == "true" {
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("HeartRed"))
                                        } else {
                                            Image(systemName: "heart")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("notFilledHeartColor"))
                                        }
                                    }
                                    
                                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input1")?["message"] ?? "")
                                        .font(.custom("Poppins-Regular", size: 20))
                                        .foregroundColor(Color("responseColor"))
                                }//end HStack
                                .padding(.bottom, 1)
                                
                                //Input2
                                HStack{
                                    Button(action: {
                                        self.viewModel.addFavoriteGrat(stringDate: sharedData.selectedDate, whichInput: "Input2")
                                    }) {
                                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input2")?["favorite"] == "true" {
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("HeartRed"))
                                        } else {
                                            Image(systemName: "heart")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("notFilledHeartColor"))
                                        }
                                    }
                                    
                                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input2")?["message"] ?? "")
                                        .font(.custom("Poppins-Regular", size: 20))
                                        .foregroundColor(Color("responseColor"))
                                }//end HStack
                                .padding(.bottom, 1)
                                
                                //Input3
                                HStack{
                                    Button(action: {
                                        self.viewModel.addFavoriteGrat(stringDate: sharedData.selectedDate, whichInput: "Input3")
                                    }) {
                                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input3")?["favorite"] == "true" {
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("HeartRed"))
                                        } else {
                                            Image(systemName: "heart")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("notFilledHeartColor"))
                                        }
                                    }
                                    
                                    Text(viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input3")?["message"] ?? "")
                                        .font(.custom("Poppins-Regular", size: 20))
                                        .foregroundColor(Color("responseColor"))
                                }//end HStack
                                .padding(.bottom, 1)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } //END GRAT
                        
                        
                        //DIVIDER
                        if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: sharedData.selectedDate, whichInput: "Input1")?["message"] != nil{
                            VStack(spacing: 0) {
                                Divider().background(Color("lineColor")).frame(height: 10)
                                //height does nothing
                            }
                        }
                        
                        //OPEN
                        if let OpenData = viewModel.getOpen(with: viewModel.savedOpens, stringDate: sharedData.selectedDate) {
                            CView(
                                title: "Open Journal",
                                message: OpenData["message"] ?? "",
                                isFavorite: viewModel.getOpen(with: viewModel.savedOpens, stringDate: sharedData.selectedDate)?["favorite"] == "true",
                                onToggleFavorite: { viewModel.addFavoriteOpen(stringDate: sharedData.selectedDate) }
                            )
                        }
                    }//end VStack
                }//end ZStack
                
                
                
                
                
                Spacer()
            }//end VStack
        }//end ScrollView
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .background(Color("NEWbackground"))
    }
}

struct newCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        newCalendarView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
