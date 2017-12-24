//
//  addOperation.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 12/23/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation

class AddOperation: Operation {
    
    init(oldMatrix: Matrix, newMatrix: Matrix){
        super.init()
        
        self.oldMatrix = oldMatrix
        self.newMatrix = newMatrix
        
        resultMatrix = Matrix(cols: newMatrix.cols, rows: newMatrix.rows)
    }
    
    override func execute() {
        
        if oldMatrix.isEmpty {
            resultMatrix = newMatrix
            return
        }
        
        for i in 0...oldMatrix.rows - 1 {
            for j in 0...oldMatrix.cols - 1 {
                resultMatrix.matrix[i][j] = oldMatrix.matrix[i][j] + newMatrix.matrix[i][j]
            }
        }
    }
}
