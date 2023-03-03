//
//  ContentView.swift
//  Journaling App
//
//  Created by Simon Neuwirth-Stein on 3/2/23.
//

import SwiftUI
//poppins font

struct ContentView: View {
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(getCurrentDate())
                    .offset(y: -50)
                Text("Rose, Bud, Thorn")
                    .font(.title)
                    .offset(y: -50)
                Text("A Mindful Way to Reflect")
                    .font(.subheadline)
                    .offset(y: -50)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: Rose()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                            //.background(Color(red: 250 / 255, green: 242 / 255, blue: 242 / 255))
                                .foregroundColor(Color(red: 0.9803921568627451, green: 0.9254901960784314, blue: 0.8941176470588236))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.5), radius: 7)
                        }
                        NavigationLink(destination: Bud()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                                .foregroundColor(Color(red: 0.9294117647058824, green: 0.9568627450980393, blue: 0.8862745098039215))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.5), radius: 7)
                        }
                        NavigationLink(destination: Thorn()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                                .foregroundColor(Color(red: 0.9176470588235294, green: 0.9372549019607843, blue: 0.9686274509803922))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.5), radius: 7)
                        }
                    }
                }
            }
        }
    }
    
    func getCurrentDate() -> String {
        let location = Locale.current
        let currentDate = Date()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = location
        return dateFormatter.string(from: currentDate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
