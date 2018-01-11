//
//  InverseOperation.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 12/27/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation

class InverseOperation: Operation {
    
    init(oldMatrix: Matrix, newMatrix: Matrix){
        
        super.init()
        self.oldMatrix = oldMatrix
        self.newMatrix = newMatrix
        self.resultMatrix = Matrix(cols: newMatrix.cols, rows: newMatrix.rows)
    }
    
    override func execute() {
        
        if newMatrix.cols != newMatrix.rows {
            resultMatrix.det = 0
            return
        }
        
        if newMatrix.cols == 2 {
            resultMatrix = newMatrix.copy() as! Matrix
            let temp = resultMatrix.matrix[0][0]
            resultMatrix.matrix[0][0] = resultMatrix.matrix[1][1]
            resultMatrix.matrix[1][1] = temp
            resultMatrix.matrix[0][1] = (resultMatrix.matrix[0][1] as! Int) * (-1)
            resultMatrix.matrix[1][0] = (resultMatrix.matrix[1][0] as! Int) * (-1)
        }
        else {
            resultMatrix = matrixOfMinors(matrix: newMatrix)
            resultMatrix = cofactorMatrix(matrix: resultMatrix)
            resultMatrix = resultMatrix.transpose()
        }

        if newMatrix.findDeterminant() != 0 {
            resultMatrix.det = newMatrix.det
            resultMatrix.makeFractions(denom: newMatrix.det)
        }
    }
    
    func matrixOfMinors(matrix: Matrix) -> Matrix {
        
        var tempMatrix = Matrix()
        let returnMatrix = Matrix(cols: matrix.cols, rows: matrix.rows)
        
        for i in 0...matrix.rows - 1 {
            for j in 0...matrix.cols - 1 {
                tempMatrix = matrix.copy() as! Matrix
                tempMatrix.removeCol(col: j)
                tempMatrix.removeRow(row: i)
                returnMatrix.matrix[i][j] = tempMatrix.findDeterminant()
            }
        }
        
        return returnMatrix
    }
    
    func cofactorMatrix(matrix: Matrix) -> Matrix {
        
        var sign = 1
        let returnMatrix = Matrix(cols: matrix.cols, rows: matrix.rows)
        
        for i in 0...matrix.rows - 1 {
            for j in 0...matrix.cols - 1 {
                returnMatrix.matrix[i][j] = (matrix.matrix[i][j] as! Int) * sign
                sign = sign * (-1)
            }
        }
        
        return returnMatrix
    }
    
}
