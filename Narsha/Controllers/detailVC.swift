//
//  detailVC.swift
//  Narsha
//
//  Created by 김부성 on 11/14/20.
//

import UIKit

class detailVC: UIViewController {
    @IBOutlet weak var lbl: UILabel!
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = delegate?.data?["name"] as? String
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
