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
    
    
    var body: some View {
        
        Text("Mindfulness Responses")
        Text("at a Glance")
        
        HStack{
            Button(action: {
                //thing for button to do
            }) {
                Text("Week")
            }
            
            Button(action: {
                //thing for button to do
            }) {
                Text("Month")
            }
        } //end HStack
        
        Text("Roses")
        
        ForEach(Array(self.viewModel.getWeekRBT(array: viewModel.savedRoses).indices), id: \.self) { index in
            HStack(){
                Button(action: {
                    let date = self.viewModel.getWeekRBT(array: viewModel.savedRoses)[index]["message"] as? String ?? ""
                    viewModel.addFavoriteRose(stringDate: date)
                }) {
                    if viewModel.Getfavorite(with: viewModel.savedRoses, stringDate: self.viewModel.getWeekRBT(array: viewModel.savedRoses)[index]["date"] as! String) == "true" {
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
                Text(self.viewModel.getWeekRBT(array: viewModel.savedRoses)[index]["message"] as? String ?? "").frame(maxWidth: .infinity, alignment: .leading)
                Text(self.dateFormatter.string(from: self.viewModel.getWeekRBT(array: viewModel.savedRoses)[index]["date"] as? Date ?? Date()))
            }//end HStack
            
        }//end ForEach

        
    }
}

struct TestFourView_Previews: PreviewProvider {
    static var previews: some View {
        TestFourView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
