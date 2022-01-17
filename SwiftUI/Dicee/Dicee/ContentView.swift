//
//  ContentView.swift
//  Dicee
//
//  Created by Le Hoang Anh on 17/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var leftDiceNumber: Int = 1
    @State private var rightDiceNumber: Int = 1
    
    var body: some View {
        ZStack {
            Image("GreenBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("DiceeLogo")
                
                Spacer()
                
                HStack(spacing: 20) {
                    DiceView(number: leftDiceNumber)
                    DiceView(number: rightDiceNumber)
                }
                .padding(.horizontal)

                Spacer()
                
                Button {
                    leftDiceNumber = Int.random(in: 1...6)
                    rightDiceNumber = Int.random(in: 1...6)
                } label: {
                    Text("Roll")
                        .font(.system(size: 50.0))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
