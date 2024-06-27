import Foundation
import CoreData
import CoreLocation

extension Park {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Park> {
        return NSFetchRequest<Park>(entityName: "Park")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
