
import Foundation
import CoreData
class Restaurant: NSManagedObject
{
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var dishes: NSSet?
}

class Dish: NSManagedObject
{
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var rating: Int
    @NSManaged var restaurant: Restaurant
}
