
import UIKit
import CoreData

class ViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoreData()
        saveDataInCoreData()
        fetchResutsFromCoreData()
    }

    func setupCoreData() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveDataInCoreData() {
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        
        newUser.setValue("Shashikant", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        newUser.setValue("12", forKey: "age")
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Failed saving")
        }
    }
    
    func fetchResutsFromCoreData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
            }
            
        } catch {
            
            print("Failed")
        }

    }
}

