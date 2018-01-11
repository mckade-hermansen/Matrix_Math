//
//  ViewController.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 6/26/17.
//  Copyright © 2017 Mckade Hermansen. All rights reserved.
//

import UIKit

class MatrixVC: UIViewController {

    var rows = 0
    var cols = 0
    var matrix = Matrix()
    var oldMatrix = Matrix()
    var operation = ""
    var indexPaths = [IndexPath]()
    var fromCoreData = false
    
    @IBOutlet weak var matrixCollectionView: UICollectionView!
    @IBOutlet weak var rowTextField: UITextField!
    @IBOutlet weak var colTextField: UITextField!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    
    @IBAction func LoadMatrixButton(_ sender: UIButton) {
        
        guard let loadMatriciesVC = storyboard?.instantiateViewController(withIdentifier: "loadMatricies") as? LoadMatricies else {
            return
        }
        present(loadMatriciesVC, animated: true)
    }
    
    @IBAction func SaveMatrixButton(_ sender: UIButton) {
        
        createMatrix()
        
        let alert = UIAlertController(title: "Save Matrix", message: "Enter Matrix Title", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields?[0]
            self.matrix.save(title: (textField?.text)!)
            //print((textField?.text)!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func nextMatrixButton(_ sender: UIButton) {
        
        createMatrix()
        
        guard let operationVC = storyboard?.instantiateViewController(withIdentifier: "operations") as? Operations else {
            return
        }
        
        operationVC.lastOperation = operation
        operationVC.matrix = matrix
        operationVC.oldMatrix = oldMatrix
        present(operationVC, animated: true)
    }
    
    func createMatrix(){
        
        var path = IndexPath()
        var cell = matrixCell()
        if rows < 1 || cols < 1 {
            return
        }
        
        for i in 0...(rows - 1) {
            for j in 0...(cols - 1) {
                
                path = IndexPath(item: j, section: i)
                cell = (matrixCollectionView.cellForItem(at: path) as? matrixCell ?? nil)!
                
                if cell.matrixInput.text! == "" {
                    matrix.matrix[i][j] = 0
                }
                else {
                    matrix.matrix[i][j] = Int(cell.matrixInput.text!)!
                }
            }
        }
    }
    
    @IBAction func enterMatrixButton(_ sender: UIButton) {
        
        let rowText = rowTextField.text!
        let colText = colTextField.text!
        if rowText.isEmpty || colText.isEmpty || Int(rowText) == nil || Int(colText) == nil {
            showDimentionInputError()
            return
        }
        rows = Int(rowText)!
        cols = Int(colText)!
        if rows == 0 || cols == 0 || rows > 100 || cols > 100 {
            showDimentionInputError()
            return
        }
        matrix = Matrix(cols: cols, rows: rows)
        matrixCollectionView?.reloadData()
        hideKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matrixCollectionView?.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        matrixCollectionView?.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if operation == "add" || operation == "sub" || fromCoreData {
            hideInputs()
            return
        }
        else if operation == "mul" {
            showInputs()
            rowTextField.isEnabled = false
            rowTextField.text = String(rows)
            matrixCollectionView?.reloadData()
        }
        else {
            
        }
        matrixCollectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    func hideInputs(){
        rowTextField.isHidden      = true
        colTextField.isHidden      = true
        enterButtonOutlet.isHidden = true
        titleLabel.isHidden        = true
        xLabel.isHidden            = true
    }
    
    func showInputs() {
        rowTextField.isHidden      = false
        colTextField.isHidden      = false
        enterButtonOutlet.isHidden = false
        titleLabel.isHidden        = false
        xLabel.isHidden            = false
    }
    
    func showDimentionInputError() {
        
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a number from 1-100 for both rows and columns", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension MatrixVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rows
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cols
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? matrixCell
        cell?.backgroundColor = UIColor.black
        if fromCoreData {
            cell?.matrixInput.text = String(describing: matrix.matrix[indexPath.section][indexPath.row])
        }
        indexPaths.append(indexPath)
        return cell!
    }
}

extension MatrixVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}



