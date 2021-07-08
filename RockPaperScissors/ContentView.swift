//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by kit chun on 7/7/2021.
//

import SwiftUI
func getRandomMove() -> Int {
    Int.random(in: 0 ..< 3)
}

struct ContentView: View {
    let totalRound = 5
    @State private var round = 1
    @State private var opponentMove = getRandomMove()
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var message = ""
    @State private var nextRound = false
    @State private var score = 0
    @State private var isFinished = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Round \(round)").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            VStack(spacing: 20) {
                ForEach(0 ..< 3) { index in
                    Button(action: {tappedMove(index)}, label: {
                        Image(moves[index]).renderingMode(.original).clipShape(Circle())

                    })
                }
            }
        }.alert(isPresented: $nextRound) {
            Alert(title: isFinished ? Text("Game Finished"): Text(round == totalRound ? "Final Round!":"\(totalRound - round) round(s) left..."), message: Text(message), dismissButton: isFinished ? .default(Text("play again")) {
                isFinished = false
                score = 0
                round = 1
            } : .default(Text("continue")))
        }
    }
    
    func tappedMove(_ playerMove: Int) {
        // 0, 1 -> -1 lose
        // 0, 2 -> -2 win
        // 1, 0 -> 1 win
        // 1, 2 -> -1 lose
        // 2, 0 -> 2 lose
        // 2, 1 -> 1 win
        
        
        let calculation = playerMove - opponentMove
        let shouldWin = calculation == 1 || calculation == -2
        let shouldLose = calculation == -1 || calculation == 2
        let prefixMessage = "He picked \(moves[opponentMove])"
        
        if shouldWin {
            message = "\(prefixMessage). You win!"
            score += 1
            round += 1
        } else if shouldLose {
            message = "\(prefixMessage). You lose!"
            round += 1
        } else {
            message = "\(prefixMessage). Draw, pick again!"
        }
        
        if round >= totalRound {
            message = "\(message) Your final score is \(score) out of \(totalRound)"
            isFinished = true
        }
        
        opponentMove = getRandomMove()
        
        nextRound = true
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
