//
//  Matrix.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 7/15/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation

class Matrix {
    
    var rows: Int = 0
    var cols: Int = 0
    var matrix = [[Int]]()
    var isEmpty = true
    
    init(){}
    
    init(cols: Int, rows: Int){
        
        matrix = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        self.rows = rows
        self.cols = cols
        isEmpty = false
    }
    
    func setDimensions(rows: Int, cols: Int){
        
        self.rows = rows
        self.cols = cols
    }

}
