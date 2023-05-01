//
//  TestFiveView.swift
//  JournalingAppSP
//
//  Created by Simon Neuwirth-Stein on 4/19/23.
//

/*
class SharedData: ObservableObject {
    @Published var sharedVariable: Bool = false
}
 */


import SwiftUI

struct TestFiveView: View {
    @ObservedObject var viewModel: JournalData;
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        
        ZStack {
            
            Button(action: {
                sharedData.sharedVariable.toggle()
            }) {
                Image(systemName: "plus.circle")
            }//end BUTTON
            Spacer()

            
            if sharedData.sharedVariable {
                TestSixView(viewModel: self.viewModel)
                    .offset(y: 200)
                
                
            }//END IF
            
        }//end ZStack
        
        
    }
}

struct TestFiveView_Previews: PreviewProvider {
    static var previews: some View {
        TestFiveView(viewModel: JournalData(UserProfile: Profile.empty))
    }
}
