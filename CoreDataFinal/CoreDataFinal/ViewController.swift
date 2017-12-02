//
//  ViewController.swift
//  CoreDataFinal
//
//  Created by Geoffrey Husser on 12/1/17.
//  Copyright © 2017 Geoffrey Husser. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do{
           let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        }
        catch{
            print("I'm all kinds of messed up :(")
        }
    }

    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField{ (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Number"
            textField.keyboardType = .numberPad
        }
        let action = UIAlertAction(title: "Save", style: .default){ (_) in
            let name = alert.textFields!.first!.text!
            let number = alert.textFields!.last!.text!
            print(name)
            //print(number)
            
            let person = Person(context: PersistenceService.context)
            person.name = name
            //check for number
            person.number = Int16(number)!
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].number)
        return cell
    }
}
