//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Joseph Casey on 25/09/16.
//  Copyright © 2016 Joseph Casey. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain {
    
    private var accumulator = 0.0;
    private var pendngBinaryOperation = false;
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var operations: [String:Operation] = [
        "π" : Operation.Constant(M_PI),
        "√" : Operation.Unary(sqrt),
        "cos" : Operation.Unary(cos),
        "×" : Operation.Binary({ $0 * $1 }),
        "÷" : Operation.Binary({ $0 / $1 }),
        "+" : Operation.Binary({ $0 + $1 }),
        "−" : Operation.Binary({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case Unary((Double) -> (Double))
        case Binary((Double,Double) -> (Double))
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .Unary(let function):
                accumulator = function(accumulator)
            case .Binary(let function):
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
                    pending = nil
                } else {
                    pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                }
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
                    pending = nil
                }
            }
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
}
