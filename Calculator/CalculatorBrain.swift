//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Bernard Sin Fat on 6/9/17.
//  Copyright © 2017 Bernard Sin Fat. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
//    private let resultIsPending = false
//    private let description: String?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary <String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "+/-" : Operation.unaryOperation( {-$0} ),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals,
        "C" : Operation.clear,
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            case .clear:
                accumulator = 0
            }
        }
    }
    
    mutating func decimalButtonStatus(_ value: String) -> Bool {
        if value.characters.contains(".") {
            return false
        }
        else {
            return true
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand (_ operand: Double){
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
    
}
