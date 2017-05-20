//
//  CalculatorBrain.swift
//  CalculatorSwift
//
//  Created by user127456 on 5/17/17.
//  Copyright © 2017 user127456. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperations((Double) -> Double)
        case binaryOperations((Double,Double)->Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperations(sqrt),
        "cos": Operation.unaryOperations(cos),
        "sin": Operation.unaryOperations(sin),
        "tan": Operation.unaryOperations(tan),
        "log": Operation.unaryOperations(log),
        "1/x": Operation.unaryOperations({ 1/$0 }),
        "%": Operation.unaryOperations({$0/100}),
        "±": Operation.unaryOperations({-$0}),
        "×": Operation.binaryOperations({$0 * $1}),
        "÷": Operation.binaryOperations({$0 / $1}),
        "+": Operation.binaryOperations({$0 + $1}),
        "−": Operation.binaryOperations({$0 - $1}),
        "=": Operation.equals
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: ((Double,Double) -> Double)
        let firstOperand: Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    
    mutating func performOperation(_ symbol: String)  {
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperations(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperations(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double? {
        get{
            return accumulator
        }
    }
}
