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
    @IBOutlet weak var catagorylbl: UILabel!
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var adlbl: UILabel!
    @IBOutlet weak var navermapbtn: UIButton!
    
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = delegate?.data?["name"] as? String
        namelbl.text = navigationItem.title
        var catagory = delegate?.data?["category"] as? String
        let address = delegate?.data?["address"] as? String
        
        switch catagory {
        case "rest":
            catagory = "음식점"
        case "cafe":
            catagory = "카페"
        case "mart":
            catagory = "마트"
        default:
            break
        }
        
        catagorylbl.text = "카테고리 : \(catagory!)"
        adlbl.text = "주소 : \(address!)"
        let location_x = delegate?.data?["coord_x"] as? Double
        let location_y = delegate?.data?["coord_y"] as? Double
        
        let marker = NMFMarker()
        marker.position = NMGWebMercatorCoord(x: location_x!, y: location_y!).toLatLng()
        marker.mapView = mapView
        marker.captionText = (delegate?.data!["name"] as? String)!
        let schoolmarker = NMFMarker()
        schoolmarker.position = NMGWebMercatorCoord(x: 14294906.8985458, y: 4254359.4405623).toLatLng()
        schoolmarker.captionText = "학교"
        schoolmarker.iconImage = NMF_MARKER_IMAGE_BLACK
        schoolmarker.iconTintColor = UIColor.brown
        schoolmarker.mapView = mapView
        mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGWebMercatorCoord(x: location_x!, y: location_y!).toLatLng())
        mapView.moveCamera(cameraUpdate)
        mapView.logoInteractionEnabled = true
        mapView.positionMode = .direction
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navermapbtnclicked(_ sender: Any) {
        let namestr = namelbl.text!
        // utf8 인코딩 변환
        let utf8_str = namestr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        // url String 설정
        let url = URL(string: "nmap://place?lat=\((delegate?.data?["latitude"] as? Double)!)&lng=\((delegate?.data?["longitude"] as? Double)!)&name=\(utf8_str!)&appname=kr.hs.dgsw.Narsha.guji")!
        // 앱스토어 URL 설정
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
        
        // 만약 url을 열수 있다면,
        if UIApplication.shared.canOpenURL(url) {
            // url을 오픈
            UIApplication.shared.open(url)
            //만약 아니라면
        } else {
            // 앱스토어로 가는 url을 오픈
            UIApplication.shared.open(appStoreURL)
        }
        
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
