//
//  detailVC.swift
//  Narsha
//
//  Created by 김부성 on 11/14/20.
//

import UIKit
import NMapsMap

class detailVC: UIViewController {
    
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var mapView: NMFMapView!
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = delegate?.data?["name"] as? String
        namelbl.text = navigationItem.title
        let location_x = delegate?.data?["coord_x"] as? Double
        let location_y = delegate?.data?["coord_y"] as? Double
        
        print(location_x as Any)
        print(location_y as Any)
        let marker = NMFMarker()
        marker.position = NMGWebMercatorCoord(x: location_x!, y: location_y!).toLatLng()
        marker.mapView = mapView
        marker.captionText = (delegate?.data!["name"] as? String)!
        mapView.buildingHeight = 1
        mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGWebMercatorCoord(x: location_x!, y: location_y!).toLatLng())
        mapView.moveCamera(cameraUpdate)
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.title = delegate?.detailtitle
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
