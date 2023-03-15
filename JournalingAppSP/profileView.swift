//
//  profileView.swift
//  JournalingAppSP
//
//  Created by Paul McSlarrow on 3/15/23.
//

import SwiftUI

struct profileView: View {
    let userProfile: Profile
    
    var body: some View {
        
        VStack {
            
            // User picture, name, and email
            HStack {
                UserImage(urlString: userProfile.picture)
                    .padding()
                
                Spacer()
            
                VStack {
                    HStack {
                        Spacer()
                        TextView(
                            text: userProfile.email,
                            fontSize: CustomFontSize.standardFontSize,
                            offset: 0,
                            fontType: "Poppins-regular"
                        )
                    }
                    
                    
                }.padding()
            } //Hstack
            Divider()
            Spacer()
            
            
            // User Data
            ScrollView {
                Text("Fill with user data")
            }
        }
    }
}


struct profileView_Previews: PreviewProvider {
    
    static var previews: some View {
        profileView(userProfile: Profile(
            id: "id",
            name: "Paul McSlarrow",
            email: "pmcslarrow@icloud.com",
            emailVerified: "True",
            picture: "",
            updatedAt: ""
        ))
    }
}
