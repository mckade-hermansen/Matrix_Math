//
//  Matrix.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 7/15/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation

class Matrix: NSCopying {
    
    var rows: Int = 0
    var cols: Int = 0
    var det: Int  = 0
    var matrix = [[Any]]()
    var isEmpty = true
    
    init(){}
    
    init(cols: Int, rows: Int){
        
        matrix = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        self.rows = rows
        self.cols = cols
        isEmpty = false
    }
    
    init(rows: Int, cols: Int, det: Int, matrix: [[Any]], isEmpty: Bool){
        
        self.rows = rows
        self.cols = cols
        self.det = det
        self.matrix = matrix
        self.isEmpty = isEmpty
    }
    
    func setDimensions(rows: Int, cols: Int){
        
        self.rows = rows
        self.cols = cols
    }
    
    func isSquare() -> Bool {
        
        return rows == cols
    }
    
    func removeRow(row: Int){
        
        matrix.remove(at: row)
        rows = rows - 1
    }
    
    func removeCol(col: Int){
        
        for row in 0...rows - 1 {
            matrix[row].remove(at: col)
        }
        cols = cols - 1
    }
    
    func transpose() -> Matrix {
        
        let tempMatrix = Matrix(cols: rows, rows: cols)
        
        for i in 0...rows - 1 {
            for j in 0...cols - 1 {
                tempMatrix.matrix[j][i] = matrix[i][j]
            }
        }
        
        return tempMatrix
    }
    
    func findDeterminant() -> Int {
        
        det = determinant(matrix: self)
        return det
    }
    
    func determinant(matrix: Matrix) -> Int {
        
        if matrix.cols <= 1 || matrix.rows <= 1{
            return matrix.matrix[0][0] as! Int
        }
        
        var sum = 0
        var sign = 1
        let row = matrix.matrix[0]
        
        for (index, num) in row.enumerated() {
            let subMatrix = matrix.copy() as! Matrix
            subMatrix.removeRow(row: 0)
            subMatrix.removeCol(col: index)
            sum += (num as! Int) * sign * determinant(matrix: subMatrix)
            sign = sign * (-1)
        }
        
        return sum
    }
    
    func multiplyByScalar(scalar: Double) {
        
        for i in 0...rows - 1 {
            for j in 0...cols - 1 {
                matrix[i][j] = Double(matrix[i][j] as! Int) * scalar
            }
        }
    }
    
    func makeFractions(denom: Int) {
        
        for i in 0...rows - 1 {
            for j in 0...cols - 1 {
                matrix[i][j] = reduceFraction(num: (matrix[i][j] as! Int), denom: det)
            }
        }
    }
    
    func reduceFraction(num: Int, denom: Int) -> String {
        
        let gcd = greatestCommonDivisor(num: abs(num), denom: abs(denom))
        let numerator = num / gcd
        let denominator = denom / gcd
        return "\(numerator)/\(denominator)"
    }
    
    func greatestCommonDivisor(num: Int, denom: Int) -> Int {
        
        if num == 0 {
            return denom
        }
        if denom == 0 {
            return num
        }
        return greatestCommonDivisor(num: denom, denom: num % denom)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        let copy = Matrix(rows: rows, cols: cols, det: det, matrix: matrix, isEmpty: isEmpty)
        return copy
    }

}
