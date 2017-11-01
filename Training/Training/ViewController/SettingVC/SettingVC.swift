//
//  SettingVC.swift
//  Training
//
//  Created by Fransky on 11/1/17.
//  Copyright © 2017 Emveep. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InputCellModel {
    
    var identifier : String
    var content : AnyObject?
    var controlView : UIView?
    var pickerView : UIView?
    var pickerContent : [String]?
    
    init(_ identifier:String,content:AnyObject? = nil,controlView:UIView? = nil,pickerView:UIView? = nil,pickerContent:[String]? = nil){
        self.identifier = identifier
        self.content = content
        self.controlView = controlView
        self.pickerView = pickerView
        self.pickerContent = pickerContent
    }
    
}


class SettingVC : BasicVC{
    
    var viewModel : SettingVM!
    
    var fNameField : UITextField?
    var lNameField : UITextField?
    var emailField : UITextField?
    var bDayField : UITextField?
    var genderField : UITextField?
    
    var tableContent : [InputCellModel] = []{
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func settingNavigationMenu() {
        self.navigationController?.navigationBar.isHidden = false
        self.settingNavBackBarWithTitle("Setting Page")
    }
    
    override func bindingViews(){
    }

    
    func setTableContent(){
        
        var array:[InputCellModel] = []
        
        array.append(InputCellModel("TFCell",controlView:self.fNameField))
        array.append(InputCellModel("TFCell",controlView:self.lNameField))
        array.append(InputCellModel("TFCell",controlView:self.emailField))
        
        let genderPicker = UIPickerView()
        
        let genderArray = ["Male","Female"]
        
        array.append(InputCellModel("PickerCell",controlView:self.genderField,pickerView:genderPicker,pickerContent:genderArray))

        let datePicker = UIDatePicker()
        
        array.append(InputCellModel("DatePickerCell",controlView:self.bDayField,pickerView:datePicker))
        
        array.append(InputCellModel("ButtonCell"))
        
        tableContent = array
        
        
    }
    
    
}


extension SettingVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableContent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.tableContent[indexPath.row]
        
        switch model.identifier {
        case "TFCell":
            return 50
        case "PickerCell":
            return 50
        case "DatePickerCell":
            return 50
        default:
            return UITableViewAutomaticDimension
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.tableContent[indexPath.row]
        let identifier = model.identifier
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: identifier) as! DisposedCell
        cell.selectionStyle = .none
        
        let inputView = cell.viewWithTag(1)
        
        if (identifier == "TFCell"){
            let field = inputView as! UITextField
            model.controlView = field
        }
        else if (identifier == "PickerCell"){
            let field = inputView as! UITextField
            model.controlView = field
            
            if let pickerView = model.pickerView as? UIPickerView{
               pickerView.setupForTextField(textField: field, viewController: self, doneStatus: "Done")
         
                if let array = model.pickerContent{
                let items = Observable.just(array)
                
                items.bind(to: pickerView.rx.items) { (row, element, view) in
                        guard let myView = view as? UILabel else {
                            let lbl = UILabel()
                            lbl.text = element
                            lbl.textAlignment = .center
                            return lbl
                        }
                        myView.text = element
                        return myView
                    }.disposed(by: cell.disposeBag)
                
                pickerView.rx.itemSelected.map{row,_ in return array[row]}
                    .bind(to: field.rx.text).disposed(by: cell.disposeBag)
                }
            
            }
        
            
        }
        else if(identifier == "DatePickerCell"){
            let field = inputView as! UITextField
            model.controlView = field
            
            if let pickerView = model.pickerView as? UIDatePicker{
                pickerView.setupForTextField(textField: field, viewController: self, doneStatus: "Done")
            }
            
        }
        
        return cell
        
    }
    
}

extension SettingVC:UIDatePickerDelegate{

    func dateChanged(sender: AnyObject) {
        
    }
    
    func datePickerDonePressed(sender: AnyObject) {
        
    }
    
    func datePickerCancelPressed(sender: AnyObject) {
        
    }
    
}


