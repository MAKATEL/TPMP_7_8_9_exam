import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapKit: MKMapView!
    var locManager = CLLocationManager()
    
    let parks: [(name: String, latitude: Double, longitude: Double)] = [
        ("Park of the 50th Anniversary of the Great October", 53.905546, 27.561481),
        ("Gorky Park", 53.908759, 27.563131),
        ("Victory Park", 53.915553, 27.533309),
        ("Central Botanical Garden", 53.921635, 27.603761),
        ("Chelyuskinites Park", 53.926217, 27.629993),
        ("Losyсki Park", 53.874356, 27.578569),
        ("Maksim Gorky Central Children's Park", 53.908871, 27.563010),
        ("Friendship of Peoples Park", 53.930130, 27.667820),
        ("Sevastopol Park", 53.870574, 27.647346),
        ("Park of Stones", 53.915794, 27.601327),
        ("Zeleny Lug Park", 53.955007, 27.683886),
        ("Pechersk Park", 53.889237, 27.544173),
        ("Yanka Kupala Park", 53.909567, 27.574681),
        ("Vasilyevsky Square", 53.883385, 27.515955),
        ("Grishka Park", 53.937171, 27.636560),
        ("Angarskaya Park", 53.878647, 27.668805),
        ("Drozdy Park", 53.945697, 27.463379),
        ("Minsk Sea Park", 53.947135, 27.303591),
        ("Park Dubki", 53.851007, 27.501794),
        ("Druzhba Park", 53.892895, 27.438154),
        ("Brilevichi Park", 53.865387, 27.444968),
        ("Skver Slavy", 53.916179, 27.572186),
        ("Uručča Park", 53.952431, 27.704079),
        ("Vulica Ramanaŭskaja Slabada Park", 53.897578, 27.544238)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.delegate = self
        locManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // setup mapView
        mapKit.delegate = self
        mapKit.showsUserLocation = true
        mapKit.userTrackingMode = .follow
        
        locManager.startUpdatingLocation()
        
        // Add parks to map
        addParksToMap()
    }
    
    func addParksToMap() {
        for park in parks {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: park.latitude, longitude: park.longitude)
            annotation.title = park.name
            mapKit.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
