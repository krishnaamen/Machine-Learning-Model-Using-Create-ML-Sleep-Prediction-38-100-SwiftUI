//
//  ContentView.swift
//  ML-project
//
//  Created by min phone on 14/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    var body: some View {
        NavigationView {
            Form {
                VStack{
                    Text("Mention the wake up time")
                        .font(.headline)
                    DatePicker("Please enter a time",selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                    Spacer()
                    Text("Amount of Sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount,in: 4...12,step: 0.25)
                    
                    Spacer()
                    Text("How much coffee do you take daily")
                        .font(.headline)
                    Stepper("\(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups") ",value: $coffeeAmount,in: 1...20)
                }
                
                }
            .navigationTitle("BestSleep")
            .toolbar {
                Button("Calculate",action: determineBedTime)
            }
           
        }
    }
    
    func determineBedTime(){
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
