//
//  TableViewSimpleController.swift
//  SwiftLearn
//
//  Created by iimgal on 2018/12/24.
//  Copyright © 2018 jerry. All rights reserved.
//

import UIKit
import SnapKit

class TableViewSimpleController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var table:UITableView!
    private var sendBtn:UIButton!
    let array:[String] = ["我是谁", "我从哪里来", "要到哪里去"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initTableView()
    }
    
    func initTableView() {
        self.view.backgroundColor = UIColor.white
        self.title = "我的"
        
        table = UITableView()
        self.view.addSubview(table)
        table.snp.makeConstraints({(make)in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT - STATUSBAR_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT)
        })
        self.table.backgroundColor = UIColor.white
        self.table.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        table?.tableHeaderView = headerImage
        
        sendBtn = UIButton()
        sendBtn.setTitle("logout", for: .normal)
        sendBtn.setTitleColor(UIColor.white, for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(sendBtn)
        sendBtn.snp.makeConstraints({(make)in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.table.snp.bottom).offset(20)
            make.width.equalTo(SCREEN_WIDTH*2/3)
            make.height.equalTo(40)
        })
        sendBtn.backgroundColor = UIColor(red: 32/255, green: 169/255, blue: 242/255, alpha: 1)
        sendBtn.layer.cornerRadius = 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "MineCenterCell"
        let cell:MineTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MineTableViewCell ?? MineTableViewCell(style: .default, reuseIdentifier: identifier)
        //        if cell == nil {
        //            cell = MineTableViewCell(style: .default, reuseIdentifier: identifier)
        //        }
        cell.titleLabel?.text = self.array[indexPath.row]
        cell.lineLabel?.text = ">"
        
        return cell
    }
    
    //表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //点击完成，取消高亮
    }
    
    lazy var headerImage:UIImageView = {
        let headerImage = UIImageView()
        headerImage.image = UIImage(named: "cat")
        headerImage.frame = CGRect.init(x:0,y:0,width:SCREEN_WIDTH,height:200)
        return headerImage
    }()
}
