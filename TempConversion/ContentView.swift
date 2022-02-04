//
//  ContentView.swift
//  TempConversion
//
//  Created by Raymond Chen on 2/3/22.
//
// Summary: Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.

import SwiftUI

struct ContentView: View {
    
    @State private var convertUnit: UnitTemperature = .celsius
    @State private var toUnit: UnitTemperature = .kelvin
    @State private var convertDegrees: Double = 0.0
    @FocusState private var convertUnitIsFocused: Bool

    
    private var toDegrees: Measurement<UnitTemperature>{
        let inputValue  = Measurement(value: convertDegrees, unit: convertUnit)
        let outputValue = inputValue.converted(to: toUnit)
        return outputValue
   }
    
    private let formatStyle = Measurement<UnitTemperature>.FormatStyle(
            width: .abbreviated,
            usage: .asProvided,
            numberFormatStyle: .number
        )
    
    let degreeScales: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    let formatter: MeasurementFormatter

    init () {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
    }
    
    var body: some View {
        
        return NavigationView {
            Form {
                Section {
                    Picker("Convert", selection: $convertUnit) {
                        ForEach(degreeScales, id: \.self ) { scale in
                            Text(scale.localizedString())
                        }
                    }
                    TextField("Convert", value: $convertDegrees, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($convertUnitIsFocused)
                }
                Section {
                    Picker("To", selection: $toUnit) {
                        ForEach(degreeScales, id: \.self ) { scale in
                            Text(scale.localizedString())
                        }
                    }
                    Text(toDegrees, formatter: formatter)
                }
            }
            .navigationTitle("Temp Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        convertUnitIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}

extension UnitTemperature {
    func localizedString() -> String {
        if self == UnitTemperature.kelvin  {
            return "Kelvin"
        } else if  self == UnitTemperature.celsius {
            return "Celsius"
        } else if  self == UnitTemperature.fahrenheit {
            return "Fahrenheit"
        } else {
            return "Unknown"
        }
    }
}
