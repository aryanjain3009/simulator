import UIKit
import SwiftUI

class MainViewController: UIViewController
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var restaurant: Restaurant?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let restaurant = restaurant
        {
            nameTextField.text = restaurant.name
            addressTextField.text = restaurant.address
        }
    }
    @IBAction func savedButtonPressed(_ sender: UIButton)
    {
        if let restaurant = restaurant
        {
            restaurant.name = nameTextField.text ?? ""
            restaurant.address = addressTextField.text ?? ""
        }
        else
        {
            let restaurant = Restaurant(context: context)
            restaurant.name = nameTextField.text ?? ""
            restaurant.address = addressTextField.text ?? ""
            self.restaurant = restaurant
        }
        try? context.save()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let rateDishVC = segue.destination as? RateDishViewController
        {
            rateDishVC.restaurant = restaurant
        }
    }

    var restaurantName: String?
    
    // Create the button
    let rateDishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rate Dish", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MainViewController.self, action: #selector(openRateDish), for: .touchUpInside)
        return button
    }()
    
    
    @objc func openRateDish() {
        guard let name = restaurantName else {
            return
        }
        
        // Pass the restaurant name to the Rate Dish view controller
        let rateDishViewController = RateDishViewController()
        rateDishViewController.restaurantName = name
        navigationController?.pushViewController(rateDishViewController, animated: true)
    }
}
