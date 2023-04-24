//
//  TestFiveView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/19/23.
//

import SwiftUI

struct header: View {
    let type: String
    let show: Bool
    let toggle: () -> Void
    
    
    var body: some View {
        HStack{
            Text(type)
            
            Button(action: {
                toggle()
            }) {
                if show{
                    Image(systemName: "chevron.down")
                } else{
                    Image(systemName: "chevron.up")
                }
            }//end button
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TestFiveView: View {
    @ObservedObject var viewModel: JournalData;
    
    @State private var showOpen = true
    @State private var showGrateful = true
    
    @State private var showRoses = true
    @State private var showBuds = true
    @State private var showThorns = true
    
    var body: some View {
        
        ScrollView {
            VStack{
                
                Text("Favorited Responses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Poppins-Bold", size: 24))
                Text("Favorited Responses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //START RBT
                VStack{
                    //ROSE
                    header(type: "Roses", show: showRoses, toggle: {showRoses.toggle()} )
                    if showRoses{
                        let favorites = viewModel.savedRoses
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: {viewModel.addFavoriteRose(stringDate: dateString)})
                            }//end IF
                        }//end ForEach
                    }//end IF
                    //END  ROSE
                    
                    //BUD
                    header(type: "Buds", show: showBuds, toggle: {showBuds.toggle()} )
                    if showBuds{
                        let favorites = viewModel.savedBuds
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: {viewModel.addFavoriteBud(stringDate: dateString)})
                            }//end IF
                        }//end ForEach
                    }//end IF
                    //END  BUD
                    
                    //THORN
                    header(type: "Thorns", show: showThorns, toggle: {showThorns.toggle()} )
                    if showThorns{
                        let favorites = viewModel.savedThorns
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: {viewModel.addFavoriteThorn(stringDate: dateString)})
                            }//end IF
                        }//end ForEach
                    }//end IF
                    //END  THORN
                } //END VStack RBT
                
                
              //START GRAT
                VStack{
                    header(type: "Gratitude Responses", show: showGrateful, toggle: {showGrateful.toggle()} )
                    
                    
                    VStack{
                        if showGrateful {
                            
                            ForEach(viewModel.savedGratitudes, id: \.self) { grat in
                                
                                /*
                                
                                if grat.favorite == "true"{
                                    HStack{
                                        VStack{
                                            
                                            gratHStack(
                                                       message: grat.message1,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "input1") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                    stringDate: grat.dateID, whichInput: "input1")?["favorite1"] == "true")
                                            
                                            
                                            gratHStack(
                                                       message: grat.message2,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "input2") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                       stringDate: grat.dateID, whichInput: "input1")?["favorite2"] == "true")
                                            
                                            gratHStack(
                                                       message: grat.message3,
                                                       addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "input3") },
                                                       isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                       stringDate: grat.dateID, whichInput: "input3")?["favorite3"] == "true")
                                             
                                             
                                        } //end VStack
                                        let dateString = grat.dateID
                                        let components = dateString.components(separatedBy: "-")
                                        if components.count == 3 {
                                            Text("\(components[1])/\(components[2])")
                                        }
                                    
                                    }//end HStack
                                    
                                    VStack(spacing: 0) {
                                        Divider().background(Color.blue).frame(height: 20)
                                        //height does nothing
                                    }
                                }//end IF
                                   */
                                 
                            }//end ForEach
                                     
                             
                        } //end IF showGrateful
                    }//end VStack
                     
                }//end GRAT VStack
                
                 
                
            }//end VStack
        }//end ScrollView
    
    }
}

struct TestFiveView_Previews: PreviewProvider {
    static var previews: some View {
        TestFiveView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
