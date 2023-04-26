//
//  TestFourView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/17/23.
//

import SwiftUI

struct mainH: View {
    let stringDate: String
    let isFavorite: Bool
    let message: String
    let addFavorite: () -> Void
    
    
    var body: some View {
        HStack(){
            Button(action: {
                addFavorite()
            }) {
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color("HeartRed"))
                        .frame(alignment: .leading)
                } else {
                    Image(systemName: "heart")
                        .font(.system(size: 18))
                        .foregroundColor(Color("notFilledHeartColor"))
                        .frame(alignment: .leading)
                }
            }
            
            Text(message)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color("responseColor"))
            let dateString = stringDate
            let components = dateString.components(separatedBy: "-")
            if components.count == 3 {
                Text("\(components[1])/\(components[2])")
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color("responseColor"))
            }
        }//end HStack
    }
}

struct openClose: View {
    let title: String
    let show: Bool
    let toggle: () -> Void
    
    var body: some View {
        HStack{
            Text(title)
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(Color("mainTextColor"))
            
            
            Button(action: {
                toggle()
            }) {
                if show{
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color("mainTextColor"))
                } else{
                    Image(systemName: "chevron.up")
                        .foregroundColor(Color("mainTextColor"))
                }
            }//end button
            .frame(maxWidth: .infinity, alignment: .trailing)
        }//end HStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 2)
        
    }
}

struct gratHStack: View{
    //let addFavorite: () -> Void
    let message: String
    let addFavorite: () -> Void
    let isFavorite: Bool
    
    var body: some View {
        
        HStack{
            Button(action: {
                addFavorite()
            }) {
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color("HeartRed"))
                        .frame(alignment: .leading)
                } else {
                    Image(systemName: "heart")
                        .font(.system(size: 18))
                        .foregroundColor(Color("notFilledHeartColor"))
                        .frame(alignment: .leading)
                }
            }
            Text(message).frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color("responseColor"))
        }//end HStack
    }
}

struct headerGlance: View{
    let message: String
    let show: Bool
    let toggle: () -> Void
    
    var body: some View {
        
        Text(message)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.custom("Poppins-SemiBold", size: 28))
            .foregroundColor(Color("mainTextColor"))
        HStack{
            Text("at a Glance")
                .font(.custom("Poppins-SemiBold", size: 22))
                .foregroundColor(Color("glanceColor"))
            
            Button(action: {
                toggle()
            }) {
                if show{
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color("mainTextColor"))
                } else{
                    Image(systemName: "chevron.up")
                        .foregroundColor(Color("mainTextColor"))
                }
            }//end button
        }//end HStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 4)
    }
}


struct AnalyzeView: View {
    @ObservedObject var viewModel: JournalData;
    
    let dateFormatter: DateFormatter
        
    init(viewModel: JournalData) {
        self.viewModel = viewModel
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "M/d"
    }
    
    @State var RBTperiod = "week"
    @State var OPENperiod = "week"
    @State var GRATperiod = "week"
    
    
    @State private var showMindful = true
    @State private var showOpen = true
    @State private var showGrateful = true
    
    @State private var showRoses = true
    @State private var showBuds = true
    @State private var showThorns = true
    
    
    var body: some View {
        ScrollView {
            VStack{
                
                VStack{ //RBT VStack
                    
                    headerGlance(message: "Mindfulness Responses", show: showMindful, toggle: {showMindful.toggle()})
                    
                    if showMindful {
                                                
                        HStack{
                            Button(action: {
                                RBTperiod = "week"
                                
                            }) {
                                Text("Week")
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundColor(RBTperiod == "week" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                            }
                            
                            Button(action: {
                                RBTperiod = "month"
                            }) {
                                Text("Month")
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundColor(RBTperiod == "month" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                            }
                        } //end HStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                        
                        
                        
                        //ROSE
                        VStack{
                            openClose(title: "Roses",
                                      show: showRoses,
                                      toggle: { showRoses.toggle() })
                            
                            if showRoses{
                                ForEach(self.viewModel.savedRoses, id: \.self) { rose in
                                    if viewModel.isDateInCurrentPeriod(dateString: rose.dateID, period: RBTperiod){
                                        
                                        mainH(stringDate: rose.dateID,
                                              isFavorite: viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: rose.dateID) == "true",
                                              message: rose.message,
                                              addFavorite: {viewModel.addFavoriteRBT(stringDate: rose.dateID, path: "Rose", savedType: &viewModel.savedRoses)} )
                                    }//end IF
                                }//end ForEach
                            } //end IF
                        } //end VStack
                        
                        VStack(spacing: 0) {
                            Divider().background(Color("lineColor")).frame(height: 10)
                            //height does nothing
                        }
                        
                        //BUD
                        VStack{
                            openClose(title: "Buds",
                                      show: showBuds,
                                      toggle: { showBuds.toggle() })
                            
                            if showBuds{
                                
                                ForEach(self.viewModel.savedBuds, id: \.self) { bud in
                                    if viewModel.isDateInCurrentPeriod(dateString: bud.dateID, period: RBTperiod){
    
                                        
                                        mainH(stringDate: bud.dateID,
                                              isFavorite: viewModel.Getfavorite(with: viewModel.savedBuds, stringDate: bud.dateID) == "true",
                                              message: bud.message,
                                              addFavorite: {viewModel.addFavoriteRBT(stringDate: bud.dateID, path: "Bud", savedType: &viewModel.savedBuds)} )
                                    }//end IF
                                }//end ForEach

                            } //end IF
                        } //end VStack
                        
                        VStack(spacing: 0) {
                            Divider().background(Color("lineColor")).frame(height: 10)
                            //height does nothing
                        }
                        
                        //THORN
                        VStack{
                            openClose(title: "Thorns",
                                      show: showThorns,
                                      toggle: { showThorns.toggle() })
                            
                            if showThorns{
                                ForEach(self.viewModel.savedThorns, id: \.self) { thorn in
                                    if viewModel.isDateInCurrentPeriod(dateString: thorn.dateID, period: RBTperiod){
                                        
                                        mainH(stringDate: thorn.dateID,
                                              isFavorite: viewModel.Getfavorite(with: viewModel.savedThorns, stringDate: thorn.dateID) == "true",
                                              message: thorn.message,
                                              addFavorite: {viewModel.addFavoriteRBT(stringDate: thorn.dateID, path: "Thorn", savedType: &viewModel.savedThorns)} )
                                    }//end IF
                                }//end ForEach
                            } //end IF
                        } //end VStack
                        
                        VStack(spacing: 0) {
                            Divider().background(Color("lineColor")).frame(height: 10)
                            //height does nothing
                        }
                        
                        
                    }// end IF
                }//end VStack
                
                
                //GRAT
                VStack{
                    
                    headerGlance(message: "Gratitude Responses", show: showGrateful, toggle: {showGrateful.toggle()})
                    
                    VStack{
                        if showGrateful {
                            
                            HStack{
                                Button(action: {
                                    GRATperiod = "week"
                                }) {
                                    Text("Week")
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .foregroundColor(GRATperiod == "week" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                                }
                                
                                Button(action: {
                                    GRATperiod = "month"
                                }) {
                                    Text("Month")
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .foregroundColor(GRATperiod == "month" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                                }
                            } //end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                            
                            
                            //ForEach(Array(GRATperiod).indices, id: \.self) { index in
                            ForEach(self.viewModel.savedGratitudes, id: \.self) { grat in
                                if viewModel.isDateInCurrentPeriod(dateString: grat.dateID, period: GRATperiod){
                                    
                                    HStack{
                                        VStack{
                                            gratHStack(
                                                       message: grat.message1,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input1") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                    stringDate: grat.dateID, whichInput: "Input1")?["favorite"] == "true")
                                            
                                            gratHStack(
                                                       message: grat.message2,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input2") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                       stringDate: grat.dateID, whichInput: "Input2")?["favorite"] == "true")
                                            
                                            gratHStack(
                                                       message: grat.message3,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input3") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                       stringDate: grat.dateID, whichInput: "Input3")?["favorite"] == "true")
                                            
                                        } //end VStack
                                        let dateString = grat.dateID
                                        let components = dateString.components(separatedBy: "-")
                                        if components.count == 3 {
                                            Text("\(components[1])/\(components[2])")
                                        }
                                    }//end HStack
                                    
                                    VStack(spacing: 0) {
                                        Divider().background(Color("lineColor")).frame(height: 10)
                                        //height does nothing
                                    }
                                }//end IF
                            }//end ForEach
                            
                        } //end IF showGrateful
                    }//end VStack
                }//end GRAT VStack
                
                
                //OPEN
                VStack{
                    
                    headerGlance(message: "Open Journal Responses", show: showOpen, toggle: {showOpen.toggle()})
                    
                    VStack{
                        if showOpen {
                            
                            HStack{
                                Button(action: {
                                    OPENperiod = "week"
                                }) {
                                    Text("Week")
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .foregroundColor(OPENperiod == "week" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                                    
                                }
                                
                                Button(action: {
                                    OPENperiod = "month"
                                }) {
                                    Text("Month")
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .foregroundColor(OPENperiod == "month" ? Color("wmSelectedColor") : Color("wmNonSelectedColor"))
                                }
                            } //end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                            
                            
                            ForEach(self.viewModel.savedOpens, id: \.self) { opens in
                                
                                if viewModel.isDateInCurrentPeriod(dateString: opens.dateID, period: OPENperiod){
                                
                                    mainH(stringDate: opens.dateID,
                                          isFavorite: viewModel.getOpen(with: viewModel.savedOpens, stringDate: opens.dateID)?["favorite"] == "true",
                                          message: opens.userInput,
                                          addFavorite: {viewModel.addFavoriteOpen(stringDate: opens.dateID)})
                                    
                                    VStack(spacing: 0) {
                                        Divider().background(Color("lineColor")).frame(height: 10)
                                        //height does nothing
                                    }
                            }//end IF
                            }//end ForEach
                        }//end IF
                    }//end VStack
                }//end VStack OPENS
                
                
                Spacer()
            }//end VStack
            
        } //end ScrollView
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .background(Color("NEWbackground"))
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}


