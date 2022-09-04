//
//  secondViewController.swift
//  coreDataFinanceTracker
//
//  Created by Manoj 07 on 10/08/22.
//

import UIKit

protocol passData{
    func passFunc()
}
    
class secondViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var data : [Tracker]?
    
    var delegate : passData?
    
    var inputViewisHidden = true
    
    var  rowData : Tracker?

    var infoTypeText : String?
    
    
    func fetchFinance(){
        
        do{
            self.data = try context.fetch(Tracker.fetchRequest())
            
            DispatchQueue.main.async {
                ViewController().tableView.reloadData()
            }
        }catch{}
        
    }

    
    let expenseButton : UIButton = {
        let button = UIButton()
        button.setTitle("Expense", for: .normal)
        button.backgroundColor = .red
        button.tag = 1
        button.addTarget(self, action: #selector(transactionButton(_:)), for: .touchUpInside)
        return button
    }()

    let incomeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Income", for: .normal)
        button.backgroundColor = .green
        button.tag = 2
        button.addTarget(self, action: #selector(transactionButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    @objc func transactionButton(_ sender : UIButton){
        datainputView.isHidden = false

        if sender.tag == 1{
            datainputView.backgroundColor = .red
            infoTypeText = "Expense"
        }else{
            datainputView.backgroundColor = .green
            infoTypeText = "Income"
        }
        
    }
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.tag = 3
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()
    
    
    @objc func saveData(){
        if rowData == nil{
            addNewPerson()
        }else{
            updatePerson()
        }
        
        do{
            try self.context.save()
        }catch{}
                
        navigationController?.popViewController(animated: true)

    }

    func addNewPerson(){
        let newinput = Tracker(context: self.context)
        newinput.category = categoryField.text ?? "food"
        newinput.amount = Double(amountField.text!) ?? 0.0
        newinput.infotype =  infoTypeText
        
    }

    func updatePerson(){
        rowData!.category = categoryField.text ?? "food"
        rowData!.amount = Double(amountField.text!) ?? 0.0
        self.delegate?.passFunc()
    }
        
        
    let datainputView = UIView()
    let categoryField : UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Category"
        return txtField
    }()
    let amountField : UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Amount"
        return txtField
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        expenseButton.frame = CGRect(x: 0, y: 65, width: view.frame.width/2, height: 50)
        incomeButton.frame = CGRect(x: view.frame.midX, y: 65, width: view.frame.width/2, height: 50)
        
        datainputView.frame.size = CGSize(width: view.frame.width-40, height: view.frame.width-40)
        datainputView.center = view.center
        categoryField.frame = CGRect(x: 10, y: 25, width: datainputView.frame.width-20, height: 50)
        amountField.frame = CGRect(x: 10, y: 100, width: datainputView.frame.width-20, height: 50)
        amountField.backgroundColor = .white

        saveButton.frame = CGRect(x: datainputView.frame.width/2-50, y: 190, width: 100, height: 50)
        
        datainputView.addSubview(categoryField)
        datainputView.addSubview(amountField)
        datainputView.addSubview(saveButton)
        
        view.addSubview(expenseButton)
        view.addSubview(incomeButton)
        view.addSubview(datainputView)
        
        datainputView.isHidden = inputViewisHidden
    }
    
}

