import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var nameTable: UITableView!
    @IBOutlet weak var imageTable: UITableView!
    @IBOutlet weak var chooseImageButton: UIButton!

    var students = [NSManagedObject]()
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTable.delegate = self
        nameTable.dataSource = self
        
        imageTable.delegate = self
        imageTable.dataSource = self

        // Установка локализованного текста кнопок и других элементов
        addButton.setTitle(NSLocalizedString("add_button", comment: ""), for: .normal)
        InputField.placeholder = NSLocalizedString("enter_student_name", comment: "")
        chooseImageButton.setTitle(NSLocalizedString("choose_image_button", comment: ""), for: .normal)

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
        if tableView == nameTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
            let student = students[indexPath.row]
            cell.textLabel?.text = student.value(forKey: "name") as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            let studentImageView = cell.viewWithTag(1) as! UIImageView
            let student = students[indexPath.row]
            
            if let imageData = student.value(forKey: "image") as? Data {
                studentImageView.image = UIImage(data: imageData)
            } else {
                studentImageView.image = UIImage(named: "placeholderImage") // Изображение по умолчанию
            }
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            managedObjectContext.delete(students[indexPath.row])

            do {
                try managedObjectContext.save()
                students.remove(at: indexPath.row)
                nameTable.deleteRows(at: [indexPath], with: .left)
                imageTable.deleteRows(at: [indexPath], with: .left)
            } catch let error as NSError {
                print("\(NSLocalizedString("data_removing_error", comment: "")): \(error)")
            }
        }
    }

    @IBAction func addStudentButtonTapped(_ sender: AnyObject) {
        guard let text = InputField.text, !text.isEmpty else {
            InputField.placeholder = NSLocalizedString("enter_student_name", comment: "")
            return
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "Students", into: managedObjectContext)
        newObject.setValue(text, forKey: "name")

        // Добавьте выбранное изображение, если оно есть
        if let image = selectedImage, let imageData = image.pngData() {
            newObject.setValue(imageData, forKey: "image")
        }

        do {
            try managedObjectContext.save()
            students.append(newObject)
            InputField.text = ""
            selectedImage = nil
            nameTable.reloadData()
            imageTable.reloadData()
            self.view.endEditing(true)
            print("Student \(text) added successfully.")
        } catch let error as NSError {
            print("\(NSLocalizedString("data_saving_error", comment: "")): \(error), \(error.userInfo)")
        }
    }

    @IBAction func chooseImageButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStudents()
        nameTable.reloadData()
        imageTable.reloadData()
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
            print("\(NSLocalizedString("data_loading_error", comment: "")): \(error), \(error.userInfo)")
        }
    }
}
