
import UIKit

class RateDishViewController: UIViewController
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    
    var dish: Dish?
    var restaurant: Restaurant?
    var restaurantName: String?

    
    let context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let dish = dish
        {
            nameTextField.text = dish.name
            typeTextField.text = dish.type
            ratingTextField.text = String(dish.rating)
        }
    }
    @IBAction func saveButtonPressed(_ sender: UIButton)
    {
        if let dish = dish
        {
            dish.name = nameTextField.text ?? ""
            dish.type = typeTextField.text ?? ""
            dish.rating = Int(ratingTextField.text ?? "") ?? 0
        }
        else if let restaurant = restaurant
        {
            let dish = Dish(context: context)
            dish.name = nameTextField.text ?? ""
            dish.type = typeTextField.text ?? ""
            dish.rating = Int(ratingTextField.text ?? "") ?? 0
            dish.restaurant = restaurant
            self.dish = dish
        }
        try? context.save()
    }
}
