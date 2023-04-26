

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

struct FavoriteView: View {
    @ObservedObject var viewModel: JournalData;
    
    @State private var showOpen = true
    @State private var showGrateful = true
    
    @State private var showRoses = true
    @State private var showBuds = true
    @State private var showThorns = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ScrollView {
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("responseColor"))
                        .font(.system(size: 30))
                    Spacer()
                }
            }
                .padding(.bottom)
            
        
            VStack{
                
                Text("Favorited Responses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Poppins-SemiBold", size: 28))
                    .padding(.bottom, 3)
                    .foregroundColor(Color("HeaderColor"))
                
                //START RBT
                VStack{
                    
                    //ROSE
                    openClose(title: "Roses", show: showRoses, toggle: { showRoses.toggle() })
                    if showRoses{
                        let favorites = viewModel.savedRoses
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: { viewModel.addFavoriteRBT(stringDate: dateString, path: "Rose", savedType: &viewModel.savedRoses) })
                                
                                
                            }//end IF
                        }//end ForEach
                    }//end IF
                    VStack(spacing: 0) { Divider().background(Color("lineColor")).frame(height: 10) }
                    //END  ROSE VStack
                    
                    //BUD
                    
                    openClose(title: "Buds", show: showBuds, toggle: { showBuds.toggle() })
                    if showBuds{
                        let favorites = viewModel.savedBuds
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: { viewModel.addFavoriteRBT(stringDate: dateString, path: "Bud", savedType: &viewModel.savedBuds) })
                            }//end IF
                        }//end ForEach
                    }//end IF
                    VStack(spacing: 0) { Divider().background(Color("lineColor")).frame(height: 10) }
                    //END  BUD
                    
                //THORN
                
                    openClose(title: "Thorns", show: showThorns, toggle: { showThorns.toggle() })
                    if showThorns{
                        let favorites = viewModel.savedThorns
                        
                        ForEach(favorites, id: \.self) { favorite in
                            
                            let message = favorite.message
                            let dateString = favorite.dateID
                            
                            if favorite.favorite == "true"{
                                
                                mainH(stringDate: dateString,
                                      isFavorite: viewModel.Getfavorite(with: favorites, stringDate: dateString) == "true",
                                      message: message,
                                      addFavorite: { viewModel.addFavoriteRBT(stringDate: dateString, path: "Thorn", savedType: &viewModel.savedThorns) })
                            }//end IF
                        }//end ForEach
                    }//end IF
                    VStack(spacing: 0) { Divider().background(Color("lineColor")).frame(height: 10) }
                //END  THORN
                } //END VStack RBT
                
                
              //START GRAT
                VStack{
                    openClose(title: "Gratitude Responses", show: showGrateful, toggle: { showGrateful.toggle() })
                    
                    if showGrateful {
                        
                        
                        ForEach(self.viewModel.savedGratitudes, id: \.self) { grat in
                            
                            if grat.favorite1 == "true" {
                                mainH(stringDate: grat.dateID,
                                      isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                                         stringDate: grat.dateID, whichInput: "Input1")?["favorite"] == "true",
                                      message: grat.message1,
                                      addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input1") })
                            }
                            
                            
                            if grat.favorite2 == "true" {
                                mainH(stringDate: grat.dateID,
                                      isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                                         stringDate: grat.dateID, whichInput: "Input2")?["favorite"] == "true",
                                      message: grat.message2,
                                      addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input2") })
                            }
                            
                            if grat.favorite3 == "true" {
                                mainH(stringDate: grat.dateID,
                                      isFavorite: self.viewModel.getGrat(array: self.viewModel.savedGratitudes,
                                                                         stringDate: grat.dateID, whichInput: "Input3")?["favorite"] == "true",
                                      message: grat.message3,
                                      addFavorite: { self.viewModel.addFavoriteGrat(stringDate: grat.dateID, whichInput: "Input3") })
                            }
                             
                            }//end ForEach
                        
                        VStack(spacing: 0) {
                            Divider().background(Color("lineColor")).frame(height: 10)
                        }
                                     
                        } //end IF showGrateful
                    }//end GRAT VStack
                
                
                //OPEN
                VStack{
                    
                    openClose(title: "Open Journal Responses", show: showOpen, toggle: { showOpen.toggle() })
                    
                    /*
                    VStack{
                        if showOpen {
                 
                            ForEach(self.viewModel.savedOpens, id: \.self) { opens in
                                
                                mainH(stringDate: opens.dateID,
                                      isFavorite: self.viewModel.getOpen(with: self.viewModel.savedOpens, stringDate: opens.dateID)?["favorite"] == "true",
                                      message: opens.message,
                                      addFavorite: { self.viewModel.addFavoriteOpen(stringDate: opens.dateID) })
                                
                                VStack(spacing: 0) { Divider().background(Color("lineColor")).frame(height: 10) }
                                
                            }//end ForEach
                        }//end IF
                    }//end VStack
                     */
                }//end VStack OPENS
                
                
            }//end VStack
        }//end ScrollView
        .padding(.top, 10)
        .padding(.horizontal, 10)
        .background(Color("NEWbackground"))
        .navigationBarBackButtonHidden(true)
         
    
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
