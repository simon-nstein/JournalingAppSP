//
//  openView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/25/23.
//

import SwiftUI

struct openView: View {
    @ObservedObject var viewModel: JournalData;
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            VStack{
                //BACK BUTTON
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("NextArrowBackgroundColor"))
                            .font(.system(size: 30))
                        Spacer()
                    }
                } //END BACK BUTTON
                .padding(.top)
                .padding(.leading)
                
                InputView(viewModel: viewModel, type: "OPEN")
                
            }//end VStack
            .background(Color("NEWbackground"))
        }//end NavView
        .navigationBarBackButtonHidden(true)
        .background(Color("NEWbackground"))
        
        
        
    }
}

struct openView_Previews: PreviewProvider {
    static var previews: some View {
        openView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
