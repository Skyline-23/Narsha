//
//  Cell.swift
//  Narsha
//
//  Created by 김부성 on 11/10/20.
//

import UIKit

class customCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cellimg: UIImageView!
    //이미지를 가져올때 리로드를 판별
    var finishReload: Bool = false
}
