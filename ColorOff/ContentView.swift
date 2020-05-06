//
//  ContentView.swift
//  ColorOff
//
//  Created by Sam on 2020-05-03.
//  Copyright © 2020 Sam. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        //Text("Hello, World!")
        // Target Color block
        VStack {
            HStack {
                VStack {
                    Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                    Text("Match this color!")
                }
                VStack {
                    Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    HStack {
                        Text("R: \(Int(rGuess * 255.0))")
                        Text("G: \(Int(gGuess * 255.0))")
                        Text("B: \(Int(bGuess * 255.0))")
                    }
                }
            }
            Text("Guess using these sliders:")
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
            
            Button(action: {
                self.showAlert = true
            }) {
                Text("Am I a true designer?")
            }.alert(isPresented: $showAlert) {
                var messageText = "You're a noob!"
                
                if computeScore()>=40 {
                    messageText = "Well, you're not colorblind."
                }
                
                if computeScore()>=60 {
                    messageText = "Not bad laaa"
                }
                
                if computeScore()>=80 {
                    messageText = "At this level, you'll get a decent job."
                }
                
                if computeScore()>=90 {
                    messageText = "Designer you are!"
                }
                
                if computeScore()>=95 {
                    messageText = "I get it, show off :D"
                }
                
                if computeScore()>=100 {
                    messageText = "Fine, you win :)"
                }
                
                return Alert(title: Text("\(messageText)"), message: Text("\(computeScore())"))
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack{
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
            //Slider(value: #rGuess)
            Text("255").foregroundColor(textColor)
        }.padding()
    }
}
