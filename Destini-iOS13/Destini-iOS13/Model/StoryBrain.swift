//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct StoryBrain {

    var storyNumber = 0
    
    let stories = [
        Story(
            title: "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: 'Need a ride, boy?'.",
            firstChoice: "I'll hop in. Thanks for the help!", firstChoiceDestination: 2,
            secondChoice: "Better ask him if he's a murderer first.", secondChoiceDestination: 1
        ),
        Story(
            title: "He nods slowly, unfazed by the question.",
            firstChoice: "At least he's honest. I'll climb in.", firstChoiceDestination: 2,
            secondChoice: "Wait, I know how to change a tire.", secondChoiceDestination: 3
        ),
        Story(
            title: "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.",
            firstChoice: "I love Elton John! Hand him the cassette tape.", firstChoiceDestination: 5,
            secondChoice: "It's him or me! You take the knife and stab him.", secondChoiceDestination: 4
        ),
        Story(
            title: "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?",
            firstChoice: "The", firstChoiceDestination: 0,
            secondChoice: "End", secondChoiceDestination: 0
        ),
        Story(
            title: "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.",
            firstChoice: "The", firstChoiceDestination: 0,
            secondChoice: "End", secondChoiceDestination: 0
        ),
        Story(
            title: "You bond with the murderer while crooning verses of 'Can you feel the love tonight'. He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: 'Try the pier.'",
            firstChoice: "The", firstChoiceDestination: 0,
            secondChoice: "End", secondChoiceDestination: 0
        )
    ]
    
    mutating func nextStory(userChoice: String) {
        if userChoice == stories[storyNumber].firstChoice {
            self.storyNumber = stories[storyNumber].firstChoiceDestination
        } else {
            self.storyNumber = stories[storyNumber].secondChoiceDestination
        }
    }
    
    func getTitle() -> String {
        return stories[storyNumber].title
    }
    
    func getFirstChoice() -> String {
        return stories[storyNumber].firstChoice
    }
    
    func getSecondChoice() -> String {
        return stories[storyNumber].secondChoice
    }
    
}
