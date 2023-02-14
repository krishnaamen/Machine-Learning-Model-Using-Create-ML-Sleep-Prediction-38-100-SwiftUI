//
//  ContentView.swift
//  ML-project
//
//  Created by min phone on 14/02/2023.
//
import CoreML
import SwiftUI


struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0){
                    Text("Mention the wake up time")
                        .font(.headline)
                    DatePicker("Please enter a time",selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                    Spacer()
                }
                VStack (alignment: .leading, spacing: 0){
                    Text("Amount of Sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount,in: 4...12,step: 0.25)
                    
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("How much coffee do you take daily")
                        .font(.headline)
                    Stepper("\(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups") ",value: $coffeeAmount,in: 1...20)
                    
                    
                }
            }
            .navigationTitle("BestSleep")
            .toolbar {
                Button("Calculate",action: determineBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
                
            } message: {
                Text(alertMessage)
            }
           
        }
    }
    
    func determineBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepPredictor(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is ...."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch{
            alertTitle = "Something went wrong"
            alertMessage = "Sorry, there is a problem calculating......."
            
        }
        showingAlert = true
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
