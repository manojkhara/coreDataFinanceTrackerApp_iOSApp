//
//  ViewController.swift
//  coreDataFinanceTracker
//
//  Created by Manoj 07 on 10/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var data : [Tracker]?
    
    var rowobject : Tracker?
    
    func fetchFinance(){
        
        do{
            self.data = try context.fetch(Tracker.fetchRequest())

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.doCalculation()
        }catch{}
        
    }

    var delegate : passData?

    let trackerView = UIView()
    let expenseView = UIView()
    let incomeView = UIView()
    let budgetView = UIView()
    let tableView = UITableView()
    
    let expenseLabel : UILabel = {
        let label = UILabel()
        label.text = "Expense"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    let expenseDataLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label

    }()

    let incomeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Income"
        label.textAlignment = .center
        return label
    }()
    
    let incomeDataLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    
    let budgetLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Budget"
        label.textAlignment = .center
        return label
    }()

    let budgetDataLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    let button : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    @objc func didTap(){
        let vc = secondViewController()
        vc.delegate = self
        vc.saveButton.setTitle("Add New", for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFinance()
    }
    
    
    func doCalculation(){
        if data!.count > 0 {
            let incomeArray = data!.filter({$0.infotype == "Income"})
            let incomenumbers = incomeArray.map({$0.amount})
            let income = incomenumbers.reduce(0, +)

            let expenseArray = data!.filter({$0.infotype == "Expense"})
            let expensenumbers = expenseArray.map({$0.amount})
            let expense = expensenumbers.reduce(0, +)
            
            incomeDataLabel.text = "\(income)"
            expenseDataLabel.text = "\(expense)"
            budgetDataLabel.text = "\(income - expense)"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "August"
        view.backgroundColor = .white
        
        trackerView.frame = CGRect(x: 0, y: 50, width: view.frame.width , height: 120)
        
        
        expenseView.frame = CGRect(x: 0, y: 0, width: trackerView.frame.width/2, height: 70)
        expenseView.backgroundColor = .red
        
        expenseLabel.frame = CGRect(x: 0, y: 0, width: expenseView.frame.width, height: expenseView.frame.height/2)
        
        expenseDataLabel.frame = CGRect(x: 0, y: expenseView.frame.midY, width: expenseView.frame.width, height: expenseView.frame.height/2)

        expenseView.addSubview(expenseLabel)
        expenseView.addSubview(expenseDataLabel)

        
        incomeView.frame = CGRect(x: trackerView.frame.midX, y: 0, width: trackerView.frame.width/2, height: 70)
        incomeView.backgroundColor = .green
        incomeLabel.frame = CGRect(x: 0, y: 0, width: incomeView.frame.width, height: incomeView.frame.height/2)
        incomeDataLabel.frame = CGRect(x: 0, y: incomeView.frame.midY, width: incomeView.frame.width, height: incomeView.frame.height/2)
        
        incomeView.addSubview(incomeLabel)
        incomeView.addSubview(incomeDataLabel)

        
        budgetView.frame = CGRect(x: 0, y: 70, width: trackerView.frame.width, height: 50)
        budgetView.backgroundColor = .blue
        
        budgetLabel.frame = CGRect(x: 0, y: 0, width: budgetView.frame.width/2, height: budgetView.frame.height)

        budgetDataLabel.frame = CGRect(x: budgetView.frame.midX, y: 0, width: budgetView.frame.width/2, height: budgetView.frame.height)
        
        budgetView.addSubview(budgetLabel)
        budgetView.addSubview(budgetDataLabel)

        
        trackerView.addSubview(expenseView)
        trackerView.addSubview(incomeView)
        trackerView.addSubview(budgetView)
        
        view.addSubview(trackerView)
        
        button.frame = CGRect(x: view.frame.width/2 - 20, y: view.frame.height - 40, width: 40, height: 40)
        
        view.addSubview(button)
        
        tableView.frame = CGRect(x: 0, y: 190, width: view.frame.width, height: view.frame.height-230)
        tableView.register(customTableViewCell.self, forCellReuseIdentifier: customTableViewCell.identifier)
        tableView.backgroundColor = .brown
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)

    }

}



extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCell.identifier, for: indexPath) as! customTableViewCell
        cell.categoryLabel.text = data![indexPath.row].category
        cell.amountLabel.text = String(describing: data![indexPath.row].amount)
        cell.infoTypeLabel.text = data![indexPath.row].infotype
        
        if cell.infoTypeLabel.text == "Expense"{
            cell.infoTypeLabel.backgroundColor = .red
        }else{
            cell.infoTypeLabel.backgroundColor = .green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete"){
            
            (action,view,completionhandler) in
            let dataToDelete = self.data![indexPath.row]
            
            self.context.delete(dataToDelete)
            
            do{
                try self.context.save()

            }catch{}
            
            self.fetchFinance()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = secondViewController()
        rowobject = data![indexPath.row]
        
        vc.delegate = self
        vc.rowData = data![indexPath.row]
        vc.inputViewisHidden = false
        vc.saveButton.setTitle("Update", for: .normal)
        vc.categoryField.text = self.data![indexPath.row].category
        vc.amountField.text = String(describing: self.data![indexPath.row].amount)
        navigationController?.pushViewController(vc, animated: true)
        
        
        do{
            try self.context.save()
        }catch{}
        
        self.fetchFinance()

    }
    
}


extension ViewController : passData{
    func passFunc(){
        fetchFinance()
    }
    
}

