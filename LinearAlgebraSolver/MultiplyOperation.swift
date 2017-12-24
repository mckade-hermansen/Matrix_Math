//
//  MultiplyOperation.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 12/24/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation

class MultiplyOperation: Operation {
    
    init(oldMatrix: Matrix, newMatrix: Matrix){
        super.init()
        self.oldMatrix = oldMatrix
        self.newMatrix = newMatrix
        resultMatrix = Matrix(cols: newMatrix.cols, rows: oldMatrix.rows)
    }
    
    override func execute() {
        
        if oldMatrix.isEmpty {
            resultMatrix = newMatrix
            return
        }
        
        var curRow = [Int]()
        
        for i in 0...resultMatrix.rows - 1 {
            curRow.removeAll()
            curRow = findRowArray(row: i)
            for j in 0...resultMatrix.cols - 1 {
                resultMatrix.matrix[i][j] = findCell(curRow: curRow, col: j)
            }
        }
    }
    
    func findRowArray(row: Int) -> [Int]{
        
        var tempArr = [Int]()
        
        for col in 0...oldMatrix.cols - 1 {
            tempArr.append(oldMatrix.matrix[row][col])
        }
        
        return tempArr
    }
    
    func findCell(curRow: [Int], col: Int) -> Int {
        
        var sum = 0
        
        for i in 0...newMatrix.rows - 1 {
            sum += (curRow[i] * newMatrix.matrix[i][col])
        }
        
        return sum
    }
}
