
import UIKit
import CoreData


class RatedMealsTableViewController: UITableViewController {
    var restaurant: Restaurant?
    var dishes: [Dish] = []
    
    // Core Data Managed Object Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let restaurant = restaurant {
            let fetchRequest: NSFetchRequest<Dish> = NSFetchRequest(entityName: "Dish")
            fetchRequest.predicate = NSPredicate(format: "restaurant = %@", restaurant)
            dishes = try! context.fetch(fetchRequest)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratedMealCell", for: indexPath)
        
        let dish = dishes[indexPath.row]
        cell.textLabel?.text = dish.name
        cell.detailTextLabel?.text = "\(dish.type) - \(dish.rating) stars"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDish = dishes[indexPath.row]
        performSegue(withIdentifier: "rateDishSegue", sender: selectedDish)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rateDishVC = segue.destination as? RateDishViewController,
           let selectedDish = sender as? Dish {
            rateDishVC.dish = selectedDish
        }
    }
 
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in selectedIndexPaths {
                let dish = dishes[indexPath.row]
                context.delete(dish)
                dishes.remove(at: indexPath.row)
            }
            try? context.save()
            tableView.deleteRows(at: selectedIndexPaths, with: .automatic)
        }
    }
}
