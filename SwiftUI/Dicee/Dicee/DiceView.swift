//
//  DiceView.swift
//  Dicee
//
//  Created by Le Hoang Anh on 17/01/2022.
//

import SwiftUI

struct DiceView: View {
    
    let imageName: String
    
    init(number: Int) {
        let diceImageNames = [
            "DiceOne",
            "DiceTwo",
            "DiceThree",
            "DiceFour",
            "DiceFive",
            "DiceSix",
        ]
    
        let index = (number > 0 && number < 7) ? number - 1 : 0
        self.imageName = diceImageNames[index]
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(number: 1)
    }
}
