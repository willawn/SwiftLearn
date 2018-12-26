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
        print("Hello,World!");
        
        
        
        /*****************************let和var******************************/
        
        //使用let申明常量，var申明变量，常量我们只能为它赋值一次，编译的时候我们并不需要获取，可以使用多次，但是不能再次被赋值。变量是在程序运行过程中，多次被赋值的量
        let myPlaygrounWidth = 20
        var myChangeWidth = 30
        myChangeWidth = 40
        
        //常量或者变量的类型必须和你给它们的值保持一致，但是，你可以不用明确地声明类型，如果在声明的同时赋值的话，编译器会自动推断类型，例：编译器会自动推断age为整型，string为字符串（String）类型
        var age = 10
        var string = "myString"
        
        //也可以显式指定类型
        let myString:NSString = "This is String"
        
        //但是值永远不会隐式转换其他类型，如果需要一个值转换成其他类型，必须显式转换
        let testView = "The Height is "
        let height = 80
        let testViewHeight = testView + String(height)
        
        //let testViewHeight2 = testView + height 不转换会报错
        
        //有一个更方便的转换字符串的方法：右斜杠(值)
        let testViewHeight3 = testView + "\(height)"
        print(testViewHeight3)
        
        
        
        /*****************************数组和字典******************************/
        
        //数组在一个有序链表存储了多个类型相同的值，同一个值可以在数组的不同位置多次出现。Swift的数组对它们能存储的值的类型是明确的，不同于OC中NSArray和NSMutableArray，OC数组能存储任何类型的对象，并且不提供关于这些对象自身的任何信息，在Swift中，任何一个特定的数组所存储的值，类型总会被确定下来，要么显式说明，或者通过类型推断。如果你创建了一个Int类型数组，你就不能存储任何非Int类型的值插入数组
        var testStringArray = ["one", "two", "three"]
        var testShowArray:[String] = ["stringOne", "stringTwo", "stringThree"]
        //        var testArray = ["one", "two", "three", 1] 这种情况报错，因为数组前面的值已经显式的决定是String类型
        //        var testIntArray = [1, 2, "string"] 这种情况报错，因为数组前面的值已经显式的决定是Int类型
        
        //当并非显式决定时候可以后面添加as[Any]泛指各种类型，这样就不会报错
        var testArray = ["one", "two", "three", 1] as [Any]
        
        //插入、添加、替换数据等操作
        testStringArray.insert("insertString", at: 1)
        testShowArray[0...2] = ["changeString", "changeString2"];//还可以写成0..<3
        testArray.append(2)
        print(testStringArray)
        print(testShowArray)
        print(testArray)
        
        //字典是一种存储多个类型相同的值的容器，每个值都和一个唯一的Key（键）相对应，这个key在字典中就是其对应值的唯一标识，和数组不同，字典里的元素没有顺序。Swift的字典对它们能存放的键和值的类型是明确的。这不同于Objective-C的NSDictionary类和NSMutableDictionary类，Objective-C的字典能存储任何类型的对象作为键或值，并且不提供关于这些对象自身的任何信息。在Swift里，任何一个特定的字典键和值，其类型总会被确定下来，或者通过显式的类型说明，或者通过类型推断
        var dictionary = ["Ch":"China", "DB":"Dublin"]
        var showDic:Dictionary<String, String> = ["Ch":"China", "DB":"Dublin", "test": "\(1)"]
        
        //字典的存取和修改
        print(dictionary["Ch"])                      //"China"  如果字典有就是取值
        dictionary["Ch"] = "Chinese"          //修改value
        print(dictionary)                     //"["DB": "Dublin", "Ch": "Chinese"]\n"
        dictionary.updateValue("Ch", forKey: "Updata")  //拥有key就是修改 没有就相当于添加
        dictionary.removeValue(forKey: "Ch")   //移除  当字典中没有这个key时候为nil  但是在OC中会报错闪退
        
        //数组和字典都把多个值存放在一个集合里。如果你创建了一个数组或者字典，并且将之指定为变量，那么该集合就是可变的，这意味着在集合被创建后，可以通过增加或删除元素来改变集合的容量大小。相反地，如果你指定一个数组或字典为常量，那么该数组或字典就是不可变的，其容量大小不能被改变。对字典来说，不可变还意味着你不能改变字典里某个键的值。一个不可变的字典一旦被设置值后，它里面的内容就不能再改变。但是，数组的不可变性跟字典略有不同。尽管你不能进行任何可能会改变数组大小的操作，但是你可以给数组中的某个索引设置一个新的值。这使得Swift的数组在大小固定的情况下能够达到最佳的性能。
        
        
        
        /*****************************控制流******************************/
        
        //for循环
        var nameArray = ["张三", "李四", "王五", "赵六"]
        for string in nameArray {
            print(string)
        }
        for index in 1..<10 {
            //打印结果为1-9
            print(index)
        }
        for index in 1...10 {
            //打印结果为1-10
            print(index)
        }
        for index in nameArray.reversed() {
            //打印结果相反 倒序
            print(index)
        }
        for (index, i) in nameArray.enumerated() {
            print(index) //遍历索引
            print(i) //遍历元素
        }
        
        //if else
        var score = 50
        if score > 20 {
        } else {
            score += 1
        }
        print(score)
        
        //while
        var x = 2
        while x < 10 {
            x = x + 2
        }
        var m = 2
        repeat { //do改成了repeat
            m = m * 2
        } while m < 10
        
        //函数和闭包
        //定义一个传入两个String返回为String的函数
        func test(name:String, eat:String) ->String {
            return "Today:\(name) eat:\(eat)"
        }
        //函数调用
        print(test(name: "张三", eat: "ice"))
        
        //定义一个传入key 和value 返回一个字典的函数
        func redictionary(key:String, value:String) ->Dictionary<String, String> {
            var dic = [String:String]()
            dic[key] = value
            return dic
        }
        //函数调用
        let myDic:Dictionary<String, String> = redictionary(key: "myName", value: "Hou")
        print(myDic)
        
        //函数的参数是可变的，可以不传，也可以多个（求平均数）
        func getAverage(numbers:Int...) -> Float {
            var sum = 0
            let count = numbers.count
            for number in numbers {
                sum += number
            }
            let result = Float(sum) / Float(count) //swift不允许两种不同的类型做算术运算，需都为同一种类型
            return Float(result)
        }
        print(getAverage(numbers: 12, 22, 33))
        
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
