//
//  TestFourView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/17/23.
//

import SwiftUI

struct TestFourView: View {
    @ObservedObject var viewModel: JournalData;
    
    let dateFormatter: DateFormatter
        
    init(viewModel: JournalData) {
        self.viewModel = viewModel
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "M/d"
    }
    @State var ROSEperiod: [[String:Any]] = []
    @State var BUDperiod: [[String:Any]] = []
    @State var THORNperiod: [[String:Any]] = []
    @State var GRATperiod: [[String:Any]] = []
    @State var OPENperiod: [[String:Any]] = []
    
    @State private var showMindful = false
    @State private var showOpen = true
    @State private var showGrateful = true
    
    @State private var showRoses = true
    @State private var showBuds = true
    @State private var showThorns = true
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                VStack{
                    Text("Mindfulness Responses")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("at a Glance")
                        
                        Button(action: {
                            showMindful.toggle()
                        }) {
                            if showMindful{
                                Image(systemName: "chevron.down")
                            } else{
                                Image(systemName: "chevron.up")
                            }
                        }//end button
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if showMindful {
                        HStack{
                            Button(action: {
                                ROSEperiod = self.viewModel.getWeekRBT(array: viewModel.savedRoses)
                                BUDperiod = self.viewModel.getWeekRBT(array: viewModel.savedBuds)
                                THORNperiod = self.viewModel.getWeekRBT(array: viewModel.savedThorns)
                            }) {
                                Text("Week")
                            }
                            
                            Button(action: {
                                ROSEperiod = self.viewModel.getMonthRBT(array: viewModel.savedRoses)
                                BUDperiod = self.viewModel.getMonthRBT(array: viewModel.savedBuds)
                                THORNperiod = self.viewModel.getMonthRBT(array: viewModel.savedThorns)
                            }) {
                                Text("Month")
                            }
                        } //end HStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        //ROSE
                        VStack{
                            HStack{
                                Text("Roses")
                                
                                Button(action: {
                                    showRoses.toggle()
                                }) {
                                    if showRoses{
                                        Image(systemName: "chevron.down")
                                    } else{
                                        Image(systemName: "chevron.up")
                                    }
                                }//end button
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if showRoses{
                                ForEach(Array(ROSEperiod).indices, id: \.self) { index in
                                    HStack(){
                                        Button(action: {
                                            let date = ROSEperiod[index]["date"] as? String ?? ""
                                            //print("date", date)
                                            viewModel.addFavoriteRose(stringDate: date)
                                            //print("2", ROSEperiod[index]["favorite"] as? String ?? "" )
                                            
                                        }) {
                                            if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: ROSEperiod[index]["date"] as? String ?? "") == "true" {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(CustomColor.heartRed)
                                                    .frame(alignment: .leading)
                                            } else {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(Color.black)
                                                    .frame(alignment: .leading)
                                            }
                                        }
                                        
                                        Text(ROSEperiod[index]["message"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        let dateString = ROSEperiod[index]["date"] as? String ?? ""
                                        let components = dateString.components(separatedBy: "-")
                                        if components.count == 3 {
                                            Text("\(components[1])/\(components[2])")
                                        }
                                    }//end HStack
                                }//end ForEach
                            }
                        } //end VStack
                        .onAppear {
                            ROSEperiod = self.viewModel.getWeekRBT(array: viewModel.savedRoses)
                        }
                        
                        //BUD
                        VStack{
                            HStack{
                                Text("Buds")
                                
                                Button(action: {
                                    showBuds.toggle()
                                }) {
                                    if showBuds{
                                        Image(systemName: "chevron.down")
                                    } else{
                                        Image(systemName: "chevron.up")
                                    }
                                }//end button
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if showBuds{
                                ForEach(Array(BUDperiod).indices, id: \.self) { index in
                                    HStack(){
                                        Button(action: {
                                            let date = BUDperiod[index]["date"] as? String ?? ""
                                            //print("date", date)
                                            viewModel.addFavoriteBud(stringDate: date)
                                            //print("2", BUDperiod[index]["favorite"] as? String ?? "" )
                                            
                                        }) {
                                            if viewModel.Getfavorite(with: viewModel.savedBuds, stringDate: BUDperiod[index]["date"] as? String ?? "") == "true" {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(CustomColor.heartRed)
                                                    .frame(alignment: .leading)
                                            } else {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(Color.black)
                                                    .frame(alignment: .leading)
                                            }
                                        }
                                        
                                        Text(BUDperiod[index]["message"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        let dateString = BUDperiod[index]["date"] as? String ?? ""
                                        let components = dateString.components(separatedBy: "-")
                                        if components.count == 3 {
                                            Text("\(components[1])/\(components[2])")
                                        }
                                    }//end HStack
                                }//end ForEach
                            }
                        } //end VStack
                        .onAppear {
                            BUDperiod = self.viewModel.getWeekRBT(array: viewModel.savedBuds)
                        }
                        
                        
                        //THORN
                        VStack{
                            HStack{
                                Text("Thorns")
                                
                                Button(action: {
                                    showThorns.toggle()
                                }) {
                                    if showThorns{
                                        Image(systemName: "chevron.down")
                                    } else{
                                        Image(systemName: "chevron.up")
                                    }
                                }//end button
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if showThorns{
                                ForEach(Array(THORNperiod).indices, id: \.self) { index in
                                    HStack(){
                                        Button(action: {
                                            let date = THORNperiod[index]["date"] as? String ?? ""
                                            //print("date", date)
                                            viewModel.addFavoriteThorn(stringDate: date)
                                            //print("2", BUDperiod[index]["favorite"] as? String ?? "" )
                                            
                                        }) {
                                            if viewModel.Getfavorite(with: viewModel.savedThorns, stringDate: THORNperiod[index]["date"] as? String ?? "") == "true" {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(CustomColor.heartRed)
                                                    .frame(alignment: .leading)
                                            } else {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(Color.black)
                                                    .frame(alignment: .leading)
                                            }
                                        }
                                        
                                        Text(THORNperiod[index]["message"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        let dateString = THORNperiod[index]["date"] as? String ?? ""
                                        let components = dateString.components(separatedBy: "-")
                                        if components.count == 3 {
                                            Text("\(components[1])/\(components[2])")
                                        }
                                    }//end HStack
                                }//end ForEach
                                
                            }
                        } //end VStack
                        .onAppear {
                            THORNperiod = self.viewModel.getWeekRBT(array: viewModel.savedThorns)
                        }
                    }// end IF
                }//end VStack
                
                //GRAT
                VStack{
                    Text("Gratitude Responses ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("at a Glance")
                        
                        Button(action: {
                            showGrateful.toggle()
                        }) {
                            if showGrateful{
                                Image(systemName: "chevron.down")
                            } else{
                                Image(systemName: "chevron.up")
                            }
                        }//end button
                    }//end HStack
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        if showGrateful {
                            
                            HStack{
                                Button(action: {
                                    print("HERE", self.viewModel.getWeekGRAT())
                                    GRATperiod = self.viewModel.getWeekGRAT()
                                }) {
                                    Text("Week")
                                }
                                
                                Button(action: {
                                    GRATperiod = self.viewModel.getMonthGRAT()
                                }) {
                                    Text("Month")
                                }
                            } //end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            ForEach(Array(GRATperiod).indices, id: \.self) { index in
                                
                                HStack{
                                    VStack{
                                        
                                        //RESPONSE 1
                                        HStack{
                                            Button(action: {
                                                let date = GRATperiod[index]["date"] as? String ?? ""
                                                //print("date", date)
                                                viewModel.addFavoriteGrat(stringDate: date, whichInput: "Input1")
                                                //print("2", GRATperiod[index]["favorite"] as? String ?? "" )
                                                
                                            }) {
                                                //if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: ROSEperiod[index]["date"] as? String ?? "") == "true" {
                                                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: GRATperiod[index]["date"] as? String ?? "", whichInput: "Input1")?["favorite"] == "true" {
                                                    Image(systemName: "heart.fill")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(CustomColor.heartRed)
                                                        .frame(alignment: .leading)
                                                } else {
                                                    Image(systemName: "heart")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(Color.black)
                                                        .frame(alignment: .leading)
                                                }
                                            }
                                            Text(GRATperiod[index]["message1"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        }//end HStack
                                        
                                        //RESPONSE 2
                                        HStack{
                                            Button(action: {
                                                let date = GRATperiod[index]["date"] as? String ?? ""
                                                //print("date", date)
                                                viewModel.addFavoriteGrat(stringDate: date, whichInput: "Input2")
                                                //print("2", GRATperiod[index]["favorite"] as? String ?? "" )
                                                
                                            }) {
                                                //if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: ROSEperiod[index]["date"] as? String ?? "") == "true" {
                                                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: GRATperiod[index]["date"] as? String ?? "", whichInput: "Input2")?["favorite"] == "true" {
                                                    Image(systemName: "heart.fill")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(CustomColor.heartRed)
                                                        .frame(alignment: .leading)
                                                } else {
                                                    Image(systemName: "heart")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(Color.black)
                                                        .frame(alignment: .leading)
                                                }
                                            }
                                            Text(GRATperiod[index]["message2"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        }//end HStack
                                        
                                        //RESPONSE 3
                                        HStack{
                                            Button(action: {
                                                let date = GRATperiod[index]["date"] as? String ?? ""
                                                //print("date", date)
                                                viewModel.addFavoriteGrat(stringDate: date, whichInput: "Input3")
                                                //print("2", GRATperiod[index]["favorite"] as? String ?? "" )
                                                
                                            }) {
                                                //if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: ROSEperiod[index]["date"] as? String ?? "") == "true" {
                                                if viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: GRATperiod[index]["date"] as? String ?? "", whichInput: "Input3")?["favorite"] == "true" {
                                                    Image(systemName: "heart.fill")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(CustomColor.heartRed)
                                                        .frame(alignment: .leading)
                                                } else {
                                                    Image(systemName: "heart")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(Color.black)
                                                        .frame(alignment: .leading)
                                                }
                                            }
                                            Text(GRATperiod[index]["message3"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                        }//end HStack
                                        
                                    } //end VStack
                                    let dateString = GRATperiod[index]["date"] as? String ?? ""
                                    let components = dateString.components(separatedBy: "-")
                                    if components.count == 3 {
                                        Text("\(components[1])/\(components[2])")
                                    }
                                }//end HStack
                                
                                VStack(spacing: 0) {
                                    Divider().background(Color.blue).frame(height: 20)
                                    //height does nothing
                                }
                            }//end ForEach
                            
                        }//end IF
                    }.onAppear {
                        GRATperiod = self.viewModel.getWeekGRAT()
                    }
                }//end VStack
                
                //OPEN
                VStack{
                    Text("Open Journal Responses ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("at a Glance")
                        
                        Button(action: {
                            showOpen.toggle()
                        }) {
                            if showOpen{
                                Image(systemName: "chevron.down")
                            } else{
                                Image(systemName: "chevron.up")
                            }
                        }//end button
                    }//end HStack
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        if showOpen {
                            
                            HStack{
                                Button(action: {
                                    //print("HERE", self.viewModel.getWeekGRAT())
                                    OPENperiod = self.viewModel.getWeekOPEN()
                                }) {
                                    Text("Week")
                                }
                                
                                Button(action: {
                                    OPENperiod = self.viewModel.getMonthOPEN()
                                }) {
                                    Text("Month")
                                }
                            } //end HStack
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            ForEach(Array(OPENperiod).indices, id: \.self) { index in
                                
                                HStack(){
                                    Button(action: {
                                        let date = OPENperiod[index]["date"] as? String ?? ""
                                        print("date", date)
                                        viewModel.addFavoriteOpen(stringDate: date)
                                        //print("2", ROSEperiod[index]["favorite"] as? String ?? "" )
                                        
                                    }) {
                                        //if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: ROSEperiod[index]["date"] as? String ?? "") == "true" {
                                        if viewModel.getOpen(with: viewModel.savedOpens, stringDate: OPENperiod[index]["date"] as? String ?? "")?["favorite"] == "true" {
                                            
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(CustomColor.heartRed)
                                                .frame(alignment: .leading)
                                        } else {
                                            Image(systemName: "heart")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color.black)
                                                .frame(alignment: .leading)
                                        }
                                    }
                                    
                                    Text(OPENperiod[index]["userInput"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                                    let dateString = OPENperiod[index]["date"] as? String ?? ""
                                    let components = dateString.components(separatedBy: "-")
                                    if components.count == 3 {
                                        Text("\(components[1])/\(components[2])")
                                    }
                                }//end HStack
                                
                                
                                
                                VStack(spacing: 0) {
                                    Divider().background(Color.blue).frame(height: 20)
                                    //height does nothing
                                }
                            }//end ForEach
                        }//end IF
                    }//end VStack
                    .onAppear {
                        OPENperiod = self.viewModel.getWeekOPEN()
                    }
                }//end VStack
                
                
                Spacer()
            }//end VStack
            
        } //end NavView
    }
}

struct TestFourView_Previews: PreviewProvider {
    static var previews: some View {
        TestFourView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
