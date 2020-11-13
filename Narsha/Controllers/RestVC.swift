//
//  ListVC.swift
//  Narsha
//
//  Created by 김부성 on 11/10/20.
//

import UIKit
import Alamofire

class RestVC: UITableViewController {
    
    var value: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = AF.request("http://guji.c2a.kr/places/category/rest")
        request.responseJSON{ response in
            switch response.result {
            case.success (let result):
                self.value = result as! NSArray
                self.tableView.reloadData()
            case.failure (let error):
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
    
    // 섹션 갯수 지정
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return value.count
    }

    
    // row 갯수 지정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    //셀 내용 관련
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell identifier를 지정하고 재사용 큐로 지정함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! customCell
        
        // 인덱스페스 섹션으로 셀 이미지당 태그를 만듬
        cell.cellimg.tag = indexPath.section
        
        let img_url = (value[indexPath.section] as? NSDictionary)?["image_url"] as? String
        let urlStr: String = "http://guji.c2a.kr\(img_url!)"
        let placeholder: UIImage? = UIImage.init(named: "placeholder.png")
        
        // 이미지를 받아옴
        cell.cellimg.imageFromURL(urlString: urlStr, placeholder: placeholder) {
            //만약 리로드가 안되었다면
            if cell.finishReload == false {
                //리로드 판별을 리로드가 되었다고 바꿈
                cell.finishReload = true
                //업데이트를 시작함
                tableView.beginUpdates()
                //섹션들을 다시 리로드함
                tableView.reloadSections(IndexSet.init(), with: UITableView.RowAnimation.automatic)
                //업데이트를 끝냄
                tableView.endUpdates()
            }
        }

        // 셀의 textLabel을 섹션에 순서에 맞는 각각의 value를 NSDictionary로 변환하고, name값을 String으로 변환한다.
        cell.name.text = (value[indexPath.section] as? NSDictionary)?["name"] as? String
        return cell
    }
    
    

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


extension UIImageView {
    //이미지뷰에 imageFromURL함수를 추가, 호출할 때 completion
    public func imageFromURL(urlString: String, placeholder: UIImage?, completion: @escaping () -> ()) {
        //만약 이미지가 없다면, 이미지를 placeholder로 대체
        if self.image == nil {
            self.image = placeholder
        }
     
    // URLSession을 사용해서 data를 받아오고, 데이터가 없을경우 에러를 출력
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        if error != nil {
            print(error!)
            return
        }
        
        // DispatchQueue.main.async로 해서 메인큐에서 비동기 처리함.
        DispatchQueue.main.async(execute: { () -> Void in
            // 서버에서 가져온 데이터로 이미지 구성
            let image = UIImage(data: data!)
            self.image = image
            // 다음 라이프사이클을 기다리지 않고 바로 업데이트 해주기 위해 setNeedsLayout사용
            self.setNeedsLayout()
            // completion - 완료콜백, 언제 끝났는지 알 수 없기 때문에, 함수가 끝나고 completion이라는 익명함수를 실행함으로써 이 함수가 끝났다는걸 전달함
            completion()
            
            })
        // 비동기에서 멈춘 작업을 다시 실행하게 하는데, suspend를 쓰지 않았으니 필요없지만 어떠한 이유로든 멈춰 있을 수 있으니, 이 함수를 항상 실행하게 처리하기 위해서 resume을 넣어주었다.
        }).resume()
    }
}
