//
//  ViewController.swift
//  9lab_example6_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//



import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var Table: UITableView!

    var students = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Table.delegate = self
        Table.dataSource = self // Установка dataSource

        // Загрузка данных из CoreData
        loadStudents()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.value(forKey: "name") as? String // Заполняем текст ячейки таблицы значением ключа "name"
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            managedObjectContext.delete(students[indexPath.row])

            do {
                try managedObjectContext.save()
                students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            } catch let error as NSError {
                print("Data removing error: \(error)")
            }
        }
    }

    @IBAction func addStudentButtonTapped(_ sender: AnyObject) {
        guard let text = InputField.text, !text.isEmpty else {
            InputField.placeholder = "Введите данные!"
            return
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "Students", into: managedObjectContext)
        newObject.setValue(text, forKey: "name")

        do {
            try managedObjectContext.save()
            students.append(newObject)
            InputField.text = ""
            Table.reloadData()
            self.view.endEditing(true)
        } catch let error as NSError {
            print("Data saving error: \(error)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStudents()
        self.Table.reloadData()
    }

    private func loadStudents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")

        do {
            if let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                students = result
            }
        } catch let error as NSError {
            print("Data loading error: \(error)")
        }
    }
}
