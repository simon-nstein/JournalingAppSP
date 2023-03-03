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
                    .offset(y: -40)
                Text("Rose, Bud, Thorn")
                    .offset(y: -30)
                    .font(.system(size: 40))
                Text("A Mindful Way to Reflect")
                    .font(.subheadline)
                    .offset(y: -20)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: Rose()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                                .foregroundColor(Color(red: 0.9803921568627451, green: 0.9254901960784314, blue: 0.8941176470588236))
                                .cornerRadius(10)
                                //.shadow(color: Color.black.opacity(0.5), radius: 7)
                                .overlay(
                                        VStack {
                                            Text("ROSE")
                                            Text("A highlight, success, small win, or something positive that happened today.")
                                                .foregroundColor(Color(red: 0.41568627450980394, green: 0.4117647058823529, blue: 0.4117647058823529))
                                                .offset(y: 40)
                                            Spacer()
                                        }
                                            .offset(y: 30)
                                            .padding()
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                        
                                )
                        }
                        NavigationLink(destination: Bud()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                                .foregroundColor(Color(red: 0.9294117647058824, green: 0.9568627450980393, blue: 0.8862745098039215))
                                .cornerRadius(10)
                                //.shadow(color: Color.black.opacity(0.5), radius: 7)
                                .overlay(
                                        VStack {
                                            Text("BUD")
                                            Text("A challenge you experienced or something you can use more support with.")
                                                .foregroundColor(Color(red: 0.41568627450980394, green: 0.4117647058823529, blue: 0.4117647058823529))
                                                .offset(y: 40)
                                            Spacer()
                                        }
                                            .offset(y: 30)
                                            .padding()
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                        
                                )
                        }
                        NavigationLink(destination: Thorn()) {
                            Rectangle()
                                .frame(width: 300, height: 500)
                                .foregroundColor(Color(red: 0.9176470588235294, green: 0.9372549019607843, blue: 0.9686274509803922))
                                .cornerRadius(10)
                                //.shadow(color: Color.black.opacity(0.5), radius: 7)
                                .overlay(
                                        VStack {
                                            Text("THORN")
                                            Text("New ideas that have blossomed or something you are looking forward to knowing more about or experiencing.")
                                                .foregroundColor(Color(red: 0.41568627450980394, green: 0.4117647058823529, blue: 0.4117647058823529))
                                                .offset(y: 40)
                                            Spacer()
                                        }
                                            .offset(y: 30)
                                            .padding()
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                        
                                )
                        }
                    }
                }
                .padding(20)
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
