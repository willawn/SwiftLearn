//
//  MineTableViewCell.swift
//  SwiftLearn
//
//  Created by iimgal on 2018/12/20.
//  Copyright © 2018 jerry. All rights reserved.
//

import UIKit
import SnapKit

class MineTableViewCell: UITableViewCell {

    var titleLabel:UILabel?
    var linkLabel:UILabel?
    var lineLabel:UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel = UILabel()
        self.contentView.addSubview(self.titleLabel!)
        
        self.linkLabel = UILabel()
        self.contentView.addSubview(self.linkLabel!)
        
        self.lineLabel = UILabel()
        self.contentView.addSubview(self.lineLabel!)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //设置titleLabel
        self.titleLabel?.snp.makeConstraints({(make)in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        })
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        //设置linkLabel
        self.linkLabel?.snp.makeConstraints({(make)in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        })
        self.linkLabel?.font = UIFont.systemFont(ofSize: 13)
        self.lineLabel?.text = ">"
        
        //设置lineLabel
        self.lineLabel?.snp.makeConstraints({(make)in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
        self.lineLabel?.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
