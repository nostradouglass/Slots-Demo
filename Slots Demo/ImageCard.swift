//
//  ImageCard.swift
//  Slots Demo
//
//  Created by Kelly Douglass on 6/14/20.
//  Copyright © 2020 Kelly Douglass. All rights reserved.
//

import SwiftUI

struct ImageCard: View {
    
    @Binding var symbol: String
    @Binding var bg: Color
    
    var body: some View {

        Image(symbol)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(20)
        .padding(10)
        .background(bg)

    }
}

struct ImageCard_Previews: PreviewProvider {
    static var previews: some View {
        ImageCard(symbol: Binding.constant("apple"), bg: Binding.constant(Color.white))
    }
}
