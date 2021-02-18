//
//  ContentView.swift
//  TheFlagGame
//
//  Created by Anu Mittal on 07/02/21.
//  Copyright © 2021 Anu Mittal. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
  var imageName: String
  var body: some View {
    Image(imageName)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
  }
}


struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""
  @State private var score = 0
  @State private var totalAttempt = 0
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      VStack {
        Text("Pick the flag of")
          .foregroundColor(.white)
        Text(countries[correctAnswer])
          .foregroundColor(.white)
          .font(.largeTitle)
          .fontWeight(.black)
        VStack(spacing: 30) {
          ForEach(0..<3) { number in
            Button(action: {
              self.totalAttempt += 1
              self.flagTapped(number)
            }) {
              FlagImage(imageName: self.countries[number])
            }
          }

          Text("Current Score: \(score)")
            .foregroundColor(.white)
        }
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle), message: Text("\(scoreMessage)"), dismissButton: .default(Text("Continue")) {
          self.askQuestion()
      })
  }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
      scoreMessage = "Your score is \(score)"
    } else {
      scoreTitle = "Wrong"
      scoreMessage = "That’s the flag of \(countries[number])"
    }
    showingScore = true
  }
  
  func askQuestion() {
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
