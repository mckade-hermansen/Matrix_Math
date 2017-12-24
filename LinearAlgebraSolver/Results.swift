//
//  Results.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 7/4/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import Foundation
import UIKit

class Results: UIViewController {
    
    var resMatrix = Matrix()
    var operation = ""
    
    @IBOutlet weak var resultsMatrix: UICollectionView!
    
    @IBAction func StartOverPressed(_ sender: UIButton) {
        
        guard let matrixVC = storyboard?.instantiateViewController(withIdentifier: "matrix") as? MatrixVC else {
            print("Operations.swift - did not get matrixVC")
            return
        }
        matrixVC.operation = ""
        matrixVC.matrix = Matrix()
        matrixVC.oldMatrix = Matrix()
        matrixVC.rows = 0
        matrixVC.cols = 0
        
        present(matrixVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
}

extension Results: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return resMatrix.rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resMatrix.cols
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as? ResultMatrixCell
        cell?.resultCellLabel.text = String(resMatrix.matrix[indexPath.section][indexPath.row])
        return cell!
    }
}
