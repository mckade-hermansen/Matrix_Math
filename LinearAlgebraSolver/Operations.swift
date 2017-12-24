//
//  Operations.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 6/26/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation
import UIKit

class Operations: UIViewController {
    
    var operation = Operation()
    var lastOperation = ""
    var matrix = Matrix()
    var oldMatrix = Matrix()
    
    @IBAction func addButton(_ sender: UIButton) {
        
        executeOperation(op: "add")
        loadMatrixViewController(op: "add")
    }
    
    @IBAction func SubtractionButton(_ sender: UIButton) {
        
        executeOperation(op: "sub")
        loadMatrixViewController(op: "sub")
    }
    
    @IBAction func multButton(_ sender: UIButton) {
        
        executeOperation(op: "mul")
        loadMatrixViewController(op: "mul")
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        
        if lastOperation != ""{
            executeOperation(op: lastOperation)
        }
        loadResultMatrix()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func executeOperation(op: String){
        
        if op == "add" {
            operation = AddOperation(oldMatrix: oldMatrix, newMatrix: matrix)
        }
        if op == "sub" {
            operation = SubtractOperation(oldMatrix: oldMatrix, newMatrix: matrix)
        }
        if op == "mul" {
            operation = MultiplyOperation(oldMatrix: oldMatrix, newMatrix: matrix)
        }
        
        operation.execute()
    }
    
    func loadMatrixViewController(op: String){
        
        guard let matrixVC = storyboard?.instantiateViewController(withIdentifier: "matrix") as? MatrixVC else {
            print("Operations.swift - did not get matrixVC")
            return
        }
        matrixVC.operation = op
        matrixVC.matrix = operation.resultMatrix
        matrixVC.oldMatrix = matrix
        matrixVC.rows = operation.resultMatrix.rows
        matrixVC.cols = operation.resultMatrix.cols
        
        present(matrixVC, animated: true)
    }
    
    func loadResultMatrix(){
        
        guard let resultsVC = storyboard?.instantiateViewController(withIdentifier: "results") as? Results else {
            print("couldn't get results VC")
            return
        }
        resultsVC.resMatrix = operation.resultMatrix
        present(resultsVC, animated: true)
    }
    
}
