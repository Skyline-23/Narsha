//
//  MartVC.swift
//  Narsha
//
//  Created by 김부성 on 11/14/20.
//

import UIKit
import Alamofire

class MartVC: UITableViewController {
    let delegate = UIApplication.shared.delegate as? AppDelegate
    var value: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = AF.request("http://guji.c2a.kr/places/category/mart")
        request.responseJSON { response in
            switch response.result {
            case.success (let result):
                self.value = result as! NSArray
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
                let alart = UIAlertController(title: "네트워크 오류!", message: "네트워크를 다시 확인해주세요", preferredStyle: .alert)
                alart.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alart, animated: true)
                return
            }
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return value.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! customCell
        let img_url = (value[indexPath.section] as! NSDictionary)["image_url"] as! String
        let urlStr: String = "http://guji.c2a.kr\(img_url)"
        let placeholder: UIImage? = UIImage.init(named: "placehoder.png")
        
        cell.cellimg.tag = indexPath.section
        
        cell.cellimg.imageFromURL(urlString: urlStr, placeholder: placeholder) {
            if cell.finishReload == false {
                cell.finishReload = true
                tableView.beginUpdates()
                tableView.reloadSections(IndexSet.init(), with: UITableView.RowAnimation.automatic)
                tableView.endUpdates()
            }
        }
        
        cell.name.text = (value[indexPath.section] as! NSDictionary)["name"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.data = value[indexPath.section] as? NSDictionary
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailCafe" {
//            delegate?.data = (value[cellnum] as! NSDictionary)["name"] as? String
//            print(delegate?.data)
//        }
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
