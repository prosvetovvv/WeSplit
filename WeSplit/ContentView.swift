//
//  ContentView.swift
//  WeSplit
//
//  Created by Vitaly Prosvetov on 04.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    @State private var tipPercentages = [10, 15, 25, 0]
    
    var totalWithTip: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let amountPeople = Double(numberOfPeople) ?? 1
        
        let amountPerPerson = totalWithTip / amountPeople
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount")) {
                    Text("$\(totalWithTip, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
