//
//  LoadMatricies.swift
//  LinearAlgebraSolver
//
//  Created by Mckade Hermansen on 1/6/18.
//  Copyright © 2018 Mckade Hermansen. All rights reserved.
//

import UIKit
import CoreData

class LoadMatricies: UIViewController {

    let context = AppDelegate.viewContext
    var matrixCount = 0
    var matricies: [MatrixEntity]? = nil
    
    @IBOutlet weak var loadMatriciesTableView: UITableView!
    
    @IBAction func GoBackButton(_ sender: UIButton) {
        loadMatrixVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchMatricies()
        loadMatriciesTableView.reloadData()
    }
    
    func fetchMatricies() {
        
        let request: NSFetchRequest<MatrixEntity> = MatrixEntity.fetchRequest()
        let fetchedMatricies = try? context.fetch(request)
        matricies = fetchedMatricies
        matrixCount = (matricies?.count)!
    }
    
    func loadMatrixVC(matrix: Matrix = Matrix(), fromCoreData: Bool = false) {
        
        guard let matrixVC = storyboard?.instantiateViewController(withIdentifier: "matrix") as? MatrixVC else {
            return
        }
        matrixVC.matrix = matrix
        matrixVC.fromCoreData = fromCoreData
        matrixVC.rows = matrix.rows
        matrixVC.cols = matrix.cols
        present(matrixVC, animated: true)
    }
    
    func convertEntityToMatrix(entity: MatrixEntity = MatrixEntity()) -> Matrix {
     
        let returnMatrix = Matrix(cols: Int(entity.cols), rows: Int(entity.rows))
        returnMatrix.matrix = entity.matrix as! [[Any]]
        returnMatrix.det = Int(entity.det)
        
        return returnMatrix
    }
    
    func updateUI() {
        
        loadMatriciesTableView.reloadData()
    }

}

extension LoadMatricies: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matrixCount
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            context.perform {
                self.context.delete((self.matricies?[indexPath.row])!)
                do {
                    try self.context.save()
                    self.matricies?.remove(at: indexPath.row)
                } catch {
                    print("context not saved for deleting row")
                }
            }
            matrixCount -= 1
            updateUI()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "loadMatrixCell", for: indexPath)
        cell.textLabel?.text = matricies?[indexPath.row].title
        return cell
    }
}

extension LoadMatricies: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadMatrixVC(matrix: convertEntityToMatrix(entity: (matricies?[indexPath.row])!), fromCoreData: true)
    }
}
