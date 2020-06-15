//
//  ContentView.swift
//  Slots Demo
//
//  Created by Kelly Douglass on 6/14/20.
//  Copyright © 2020 Kelly Douglass. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "lemon", "donut" ]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var background = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var betAmount = 10
    

    var body: some View {
        
        ZStack {
            
            // Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color( red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                // Title
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                    
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(Color.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                //Credits Counter
                
                Text("Credits \(credits)")
                    .foregroundColor(Color.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                // Cards
                
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        ImageCard(symbol: $symbols[numbers[0]], bg: $background[0])
                        ImageCard(symbol: $symbols[numbers[1]], bg: $background[1])
                        ImageCard(symbol: $symbols[numbers[2]], bg: $background[2])
                        
                        Spacer()
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        ImageCard(symbol: $symbols[numbers[3]], bg: $background[3])
                        ImageCard(symbol: $symbols[numbers[4]], bg: $background[4])
                        ImageCard(symbol: $symbols[numbers[5]], bg: $background[5])
                        
                        Spacer()
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        ImageCard(symbol: $symbols[numbers[6]], bg: $background[6])
                        ImageCard(symbol: $symbols[numbers[7]], bg: $background[7])
                        ImageCard(symbol: $symbols[numbers[8]], bg: $background[8])
                        
                        Spacer()
                        
                    }
                }
                
                Spacer()
                
                // Button
                
                HStack(spacing: 20 ) {
                    VStack {
                        Button(action: {
                            // Change images
                            self.processResults()
                            
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) credits").padding(.top, 10).font(.footnote)
                    }
                    VStack {
                        Button(action: {
                            // Change images
                            self.processResults(true)
                            
                        }) {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) credits").padding(.top, 10).font(.footnote)
                    }
                }
                Spacer()
                
            }
        }
    }
    
    func processResults(_ isMax: Bool = false) {
        
        self.background = self.background.map({ _ in
            return Color.white
        })
        
        // Check winnings
        
        if isMax {
            // Spin all the cards
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count-1)
            })
        } else {
            // Spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        processWin(isMax)
        
    }
    
    
    func processWin(_ isMax: Bool = false) {
        
        var matches = 0
        
        if !isMax {
            // Process for single spin
            
            if isMatch(3, 4, 5) { matches += 1 }
            
        } else {
            // Process for multi max spin
            
            if isMatch(0, 1, 2) { matches += 1 }
            if isMatch(3, 4, 5) { matches += 1 }
            if isMatch(6, 7, 8) { matches += 1 }
            if isMatch(0, 4, 8) { matches += 1 }
            if isMatch(2, 4, 6) { matches += 1 }
            
        }
        
        if matches > 0 {
            self.credits += matches * betAmount * 2
        } else if !isMax {
            self.credits -= betAmount
        } else {
            self.credits -= betAmount * 5
        }
        
    }
    
    
    func isMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            
            self.background[index1] = Color.green
            self.background[index2] = Color.green
            self.background[index3] = Color.green
            
            return true
        }
        
        return false
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}
