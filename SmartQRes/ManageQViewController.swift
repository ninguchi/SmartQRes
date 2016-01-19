//
//  ManageQViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/1/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

var audioPlayer = AVAudioPlayer()

class ManageQViewController: MainDetailViewController, UITableViewDelegate, UITableViewDataSource {

    var listQueueTypeAWaiting : [Queue] = []
    var listQueueTypeBWaiting : [Queue] = []
    var listQueueTypeCWaiting : [Queue] = []
    var listQueueTypeDWaiting : [Queue] = []
    
    var listQueueTypeANoShow : [Queue] = []
    var listQueueTypeBNoShow : [Queue] = []
    var listQueueTypeCNoShow : [Queue] = []
    var listQueueTypeDNoShow : [Queue] = []
    
    var curQueueTypeA:Queue = Queue()
    var curQueueTypeB:Queue = Queue()
    var curQueueTypeC:Queue = Queue()
    var curQueueTypeD:Queue = Queue()
    
    @IBOutlet weak var tableViewTypeAWaiting: UITableView!
    @IBOutlet weak var tableViewTypeBWaiting: UITableView!
    @IBOutlet weak var tableViewTypeCWaiting: UITableView!
    @IBOutlet weak var tableViewTypeDWaiting: UITableView!
    
    @IBOutlet weak var tableViewTypeANoShow: UITableView!
    @IBOutlet weak var tableViewTypeBNoShow: UITableView!
    @IBOutlet weak var tableViewTypeCNoShow: UITableView!
    @IBOutlet weak var tableViewTypeDNoShow: UITableView!
    
    @IBOutlet weak var labelTypeA: UILabel!
    @IBOutlet weak var labelTypeB: UILabel!
    @IBOutlet weak var labelTypeC: UILabel!
    @IBOutlet weak var labelTypeD: UILabel!
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    
    @IBOutlet weak var labelWaitingA: UILabel!
    @IBOutlet weak var labelWaitingB: UILabel!
    @IBOutlet weak var labelWaitingC: UILabel!
    @IBOutlet weak var labelWaitingD: UILabel!
    
    @IBOutlet weak var labelNoShowA: UILabel!
    @IBOutlet weak var labelNoShowB: UILabel!
    @IBOutlet weak var labelNoShowC: UILabel!
    @IBOutlet weak var labelNoShowD: UILabel!
    
    @IBOutlet weak var btnCurrentTypeA: UIButton!
    @IBOutlet weak var btnCurrentTypeB: UIButton!
    @IBOutlet weak var btnCurrentTypeC: UIButton!
    @IBOutlet weak var btnCurrentTypeD: UIButton!
    
    @IBOutlet weak var btnCallNextQA: UIButton!
    @IBOutlet weak var btnCallNextQB: UIButton!
    @IBOutlet weak var btnCallNextQC: UIButton!
    @IBOutlet weak var btnCallNextQD: UIButton!
    
    
    var branchId:NSNumber = 0
    var branch = Branch()
    
    let instance = SingletonClass.shared
    
    var status = 1
    var queueNo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Retreive Branch ID
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        print("User branchid \(branchId)")
        self.branchId = branchId
        //QueueController().instance.pullItems()
        // Do any additional setup after loading the view.
        print("View Did Load")
        // Set table datasource and delegate
        tableViewTypeAWaiting.dataSource = self
        tableViewTypeAWaiting.delegate = self
        tableViewTypeBWaiting.dataSource = self
        tableViewTypeBWaiting.delegate = self
        tableViewTypeCWaiting.dataSource = self
        tableViewTypeCWaiting.delegate = self
        tableViewTypeDWaiting.dataSource = self
        tableViewTypeDWaiting.delegate = self
        tableViewTypeANoShow.dataSource = self
        tableViewTypeANoShow.delegate = self
        tableViewTypeBNoShow.dataSource = self
        tableViewTypeBNoShow.delegate = self
        tableViewTypeCNoShow.dataSource = self
        tableViewTypeCNoShow.delegate = self
        tableViewTypeDNoShow.dataSource = self
        tableViewTypeDNoShow.delegate = self
        
        
        self.btnCurrentTypeA.layer.cornerRadius = 5
        self.btnCurrentTypeB.layer.cornerRadius = 5
        self.btnCurrentTypeC.layer.cornerRadius = 5
        self.btnCurrentTypeD.layer.cornerRadius = 5
        self.btnCallNextQA.layer.cornerRadius = 5
        self.btnCallNextQB.layer.cornerRadius = 5
        self.btnCallNextQC.layer.cornerRadius = 5
        self.btnCallNextQD.layer.cornerRadius = 5
        //self.hideTrigger()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("View Did Appear")
        //NSThread.sleepForTimeInterval(3)
        self.refreshViewMethod(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableViewTypeAWaiting) {
            return listQueueTypeAWaiting.count
        }else if(tableView == self.tableViewTypeANoShow){
            return listQueueTypeANoShow.count
        }else if(tableView == self.tableViewTypeBWaiting) {
            return listQueueTypeBWaiting.count
        }else if(tableView == self.tableViewTypeBNoShow){
            return listQueueTypeBNoShow.count
        }else if(tableView == self.tableViewTypeCWaiting) {
            return listQueueTypeCWaiting.count
        }else if(tableView == self.tableViewTypeCNoShow){
            return listQueueTypeCNoShow.count
        }else if(tableView == self.tableViewTypeDWaiting) {
            return listQueueTypeDWaiting.count
        }else {
            return listQueueTypeDNoShow.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
         let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ManageQTableViewCell
        
        // Configure the cell...
        if(tableView == self.tableViewTypeAWaiting) {
            cell.labelQueueNo!.text = "\(listQueueTypeAWaiting[indexPath.row].que_tb_type)\(listQueueTypeAWaiting[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeAWaiting[indexPath.row].que_no_person)"
            if(listQueueTypeAWaiting[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeAWaiting[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeANoShow){
            cell.labelQueueNo!.text = "\(listQueueTypeANoShow[indexPath.row].que_tb_type)\(listQueueTypeANoShow[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeANoShow[indexPath.row].que_no_person)"
            if(listQueueTypeANoShow[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeANoShow[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeBWaiting) {
            cell.labelQueueNo!.text = "\(listQueueTypeBWaiting[indexPath.row].que_tb_type)\(listQueueTypeBWaiting[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeBWaiting[indexPath.row].que_no_person)"
            if(listQueueTypeBWaiting[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeBWaiting[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeBNoShow){
            cell.labelQueueNo!.text = "\(listQueueTypeBNoShow[indexPath.row].que_tb_type)\(listQueueTypeBNoShow[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeBNoShow[indexPath.row].que_no_person)"
            if(listQueueTypeBNoShow[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeBNoShow[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeCWaiting) {
            cell.labelQueueNo!.text = "\(listQueueTypeCWaiting[indexPath.row].que_tb_type)\(listQueueTypeCWaiting[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeCWaiting[indexPath.row].que_no_person)"
            if(listQueueTypeCWaiting[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeCWaiting[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeCNoShow){
            cell.labelQueueNo!.text = "\(listQueueTypeCNoShow[indexPath.row].que_tb_type)\(listQueueTypeCNoShow[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeCNoShow[indexPath.row].que_no_person)"
            if(listQueueTypeCNoShow[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeCNoShow[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeDWaiting) {
            cell.labelQueueNo!.text = "\(listQueueTypeDWaiting[indexPath.row].que_tb_type)\(listQueueTypeDWaiting[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeDWaiting[indexPath.row].que_no_person)"
            if(listQueueTypeDWaiting[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeDWaiting[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }else if(tableView == self.tableViewTypeDNoShow){
            cell.labelQueueNo!.text = "\(listQueueTypeDNoShow[indexPath.row].que_tb_type)\(listQueueTypeDNoShow[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            cell.labelNumOfPerson!.text = "\(listQueueTypeDNoShow[indexPath.row].que_no_person)"
            if(listQueueTypeDNoShow[indexPath.row].que_child_flag == "Y"){
                cell.imageChildren!.hidden = false
            }else{
                cell.imageChildren!.hidden = true
            }
            if(listQueueTypeDNoShow[indexPath.row].que_wheel_flag == "Y"){
                cell.imageWheelchair!.hidden = false
            }else{
                cell.imageWheelchair!.hidden = true
            }
        }

        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        var currentList : [Queue] = []
        if tableView == self.tableViewTypeAWaiting{
            currentList = listQueueTypeAWaiting
         }else if tableView == self.tableViewTypeBWaiting{
            currentList = listQueueTypeBWaiting
        }else if tableView == self.tableViewTypeCWaiting{
            currentList = listQueueTypeCWaiting
        }else if tableView == self.tableViewTypeDWaiting{
            currentList = listQueueTypeDWaiting
        }else if tableView == self.tableViewTypeANoShow{
            currentList = listQueueTypeANoShow
        }else if tableView == self.tableViewTypeBNoShow{
            currentList = listQueueTypeBNoShow
        }else if tableView == self.tableViewTypeCNoShow{
            currentList = listQueueTypeCNoShow
        }else{
            currentList = listQueueTypeDNoShow
        }
        // Show popup
        let msg:String = self.getContentPopup(currentList[index], index: index)
        
        let a = UIAlertController(title: "\(currentList[index].que_tb_type)\(currentList[index].que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
        
        if tableView == self.tableViewTypeAWaiting || tableView == self.tableViewTypeBWaiting || tableView == self.tableViewTypeCWaiting || tableView == self.tableViewTypeDWaiting {
            // Waiting
            //let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            //a.addAction(okButton)
            status = 0
            queueNo = "\(currentList[index].que_tb_type)\(currentList[index].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            performSegueWithIdentifier("confirmOrderSegue", sender: msg)
        }else{
            // No show
            let okButton = UIAlertAction(title: "Complete", style: .Default){
                (action) -> Void in
                self.updateToComplete(currentList[index])
                self.queueNo = "\(currentList[index].que_tb_type)\(currentList[index].que_no.integerValue.format(Constants.DecimalFormat.Queue))"
                self.performSegueWithIdentifier("confirmOrderSegue", sender: msg)
                if(currentList[index].que_tb_type == Constants.TableType.A){
                    self.listQueueTypeANoShow.removeAtIndex(index)
                    self.tableViewTypeANoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.B){
                    self.listQueueTypeBNoShow.removeAtIndex(index)
                    self.tableViewTypeBNoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.C){
                    self.listQueueTypeCNoShow.removeAtIndex(index)
                    self.tableViewTypeCNoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.D){
                    self.listQueueTypeDNoShow.removeAtIndex(index)
                    self.tableViewTypeDNoShow.reloadData()
                }
                //print("Update Selected Q Complete : Status is Completed and complete time is updated !! ")
            }
            let deleteButton = UIAlertAction(title: "Delete", style: .Default){
                (action) -> Void in
                self.updateToCancel(currentList[index])
                if(currentList[index].que_tb_type == Constants.TableType.A){
                    self.listQueueTypeANoShow.removeAtIndex(index)
                    self.tableViewTypeANoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.B){
                    self.listQueueTypeBNoShow.removeAtIndex(index)
                    self.tableViewTypeBNoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.C){
                    self.listQueueTypeCNoShow.removeAtIndex(index)
                    self.tableViewTypeCNoShow.reloadData()
                }else if(currentList[index].que_tb_type == Constants.TableType.D){
                    self.listQueueTypeDNoShow.removeAtIndex(index)
                    self.tableViewTypeDNoShow.reloadData()
                }
                //print("Update Selected Q Complete : Status is Cancelled and cancel time is updated !! ")
            }

            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            a.addAction(okButton)
            a.addAction(deleteButton)
            a.addAction(cancelButton)
        }
        self.presentViewController(a, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    @IBAction func callNextQTypeA() {
        print("Type A : Call Next Q")
        if(self.listQueueTypeAWaiting.count > 0){
            if(self.curQueueTypeA.que_status != Constants.QueueStatus.Waiting){
                // Update Current Q to Flag N
                if(self.curQueueTypeA.que_status != 0){
                    self.curQueueTypeA.que_current_flag = Constants.Flag.NO
                    QueueController().updateItem(self.curQueueTypeA)
                    //print("Current : Queue No \(self.curQueueTypeA.que_no), Queue Status \(self.curQueueTypeA.que_status), Queue Flag \(self.curQueueTypeA.que_current_flag)")
                }
                // Update Next Q to Flag Y
                self.listQueueTypeAWaiting[0].que_current_flag = Constants.Flag.YES
                self.listQueueTypeAWaiting[0].que_call_q_time = NSDate()
                QueueController().updateCurrentQItem(self.listQueueTypeAWaiting[0], uiView : self)
                //print("New Current : Queue No \(self.curQueueTypeA.que_no), Queue Status \(self.curQueueTypeA.que_status), Queue Flag \(self.curQueueTypeA.que_current_flag)")
                self.listQueueTypeAWaiting.removeAtIndex(0)
                self.tableViewTypeAWaiting.reloadData()
                self.btnCurrentTypeA.setTitle("\(self.curQueueTypeA.que_tb_type)\(self.curQueueTypeA.que_no.integerValue.format(Constants.DecimalFormat.Queue))", forState: UIControlState.Normal)
                //print("listQueueTypeAWaiting = \(self.listQueueTypeAWaiting.count)")
                            // reload No Show to update no show list
                //QueueController().instance.pullItems()
                //QueueController().getNoShowQueueListByType(branchId, type:Constants.TableType.A, uiView: self)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    self.callSound("\(self.curQueueTypeA.que_tb_type)\(self.curQueueTypeA.que_no.integerValue.format(Constants.DecimalFormat.Queue))")
                })
                
            }else{
                self.popupUpdateCurrentQStatus(self.curQueueTypeA,btnCurrent : btnCurrentTypeA, tableNoShow : tableViewTypeANoShow, isCallFromNextQ : Constants.Flag.YES)
            }
            CustomerController().sendNotiByType(Constants.TableType.A, uiView: self)
            
        }
    }
    
    @IBAction func callNextQTypeB() {
        print("Type B : Call Next Q")
        
        if(self.listQueueTypeBWaiting.count > 0){
            if(self.curQueueTypeB.que_status != Constants.QueueStatus.Waiting){
                if(self.curQueueTypeB.que_status != 0){
                    self.curQueueTypeB.que_current_flag = Constants.Flag.NO
                    QueueController().updateItem(self.curQueueTypeB)
                   // print("Cuurent : Queue No \(self.curQueueTypeB.que_no), Queue Status \(self.curQueueTypeB.que_status), Queue Flag \(self.curQueueTypeB.que_current_flag)")
                }
                self.listQueueTypeBWaiting[0].que_current_flag = Constants.Flag.YES
                self.listQueueTypeBWaiting[0].que_call_q_time = NSDate()
                QueueController().updateCurrentQItem(self.listQueueTypeBWaiting[0], uiView : self)
                //print("New Current : Queue No \(self.curQueueTypeB.que_no), Queue Status \(self.curQueueTypeB.que_status), Queue Flag \(self.curQueueTypeB.que_current_flag)")
                self.listQueueTypeBWaiting.removeAtIndex(0)
                self.tableViewTypeBWaiting.reloadData()
                self.btnCurrentTypeB.setTitle("\(self.curQueueTypeB.que_tb_type)\(self.curQueueTypeB.que_no.integerValue.format(Constants.DecimalFormat.Queue))", forState: UIControlState.Normal)
                //print("listQueueTypeBWaiting = \(self.listQueueTypeBWaiting.count)")
                //QueueController().instance.pullItems()
                //QueueController().getNoShowQueueListByType(branchId, type:Constants.TableType.B, uiView: self)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    self.callSound("\(self.curQueueTypeB.que_tb_type)\(self.curQueueTypeB.que_no.integerValue.format(Constants.DecimalFormat.Queue))")
                })
            }else{
                self.popupUpdateCurrentQStatus(self.curQueueTypeB,btnCurrent : btnCurrentTypeB, tableNoShow : tableViewTypeBNoShow, isCallFromNextQ : Constants.Flag.YES)
            }
            CustomerController().sendNotiByType(Constants.TableType.B, uiView: self)
        }
    }
    
    @IBAction func callNextQTypeC() {
        print("Type C : Call Next Q")
        
        if(self.listQueueTypeCWaiting.count > 0){
            if(self.curQueueTypeC.que_status != Constants.QueueStatus.Waiting){
                if(self.curQueueTypeC.que_status != 0){
                    self.curQueueTypeC.que_current_flag = Constants.Flag.NO
                    QueueController().updateItem(self.curQueueTypeC)
                    //print("Cuurent : Queue No \(self.curQueueTypeC.que_no), Queue Status \(self.curQueueTypeC.que_status), Queue Flag \(self.curQueueTypeC.que_current_flag)")
                }
                self.listQueueTypeCWaiting[0].que_current_flag = Constants.Flag.YES
                self.listQueueTypeCWaiting[0].que_call_q_time = NSDate()
                QueueController().updateCurrentQItem(self.listQueueTypeCWaiting[0], uiView : self)
                //print("New Current : Queue No \(self.curQueueTypeC.que_no), Queue Status \(self.curQueueTypeC.que_status), Queue Flag \(self.curQueueTypeC.que_current_flag)")
                self.listQueueTypeCWaiting.removeAtIndex(0)
                self.tableViewTypeCWaiting.reloadData()
                self.btnCurrentTypeC.setTitle("\(self.curQueueTypeC.que_tb_type)\(self.curQueueTypeC.que_no.integerValue.format(Constants.DecimalFormat.Queue))", forState: UIControlState.Normal)
               
                //QueueController().instance.pullItems()
                //QueueController().getNoShowQueueListByType(branchId, type:Constants.TableType.C, uiView: self)
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    self.callSound("\(self.curQueueTypeC.que_tb_type)\(self.curQueueTypeC.que_no.integerValue.format(Constants.DecimalFormat.Queue))")
                })
            }else{
                self.popupUpdateCurrentQStatus(self.curQueueTypeC,btnCurrent : btnCurrentTypeC, tableNoShow : tableViewTypeCNoShow, isCallFromNextQ : Constants.Flag.YES)
            }
            CustomerController().sendNotiByType(Constants.TableType.C, uiView: self)
        }
    }

    @IBAction func callNextQTypeD() {
        print("Type D : Call Next Q")
        if(self.listQueueTypeDWaiting.count > 0){
            if(self.curQueueTypeD.que_status != Constants.QueueStatus.Waiting){
                if(self.curQueueTypeD.que_status != 0){
                    self.curQueueTypeD.que_current_flag = Constants.Flag.NO
                    QueueController().updateItem(self.curQueueTypeD)
                    //print("Cuurent : Queue No \(self.curQueueTypeD.que_no), Queue Status \(self.curQueueTypeD.que_status), Queue Flag \(self.curQueueTypeD.que_current_flag)")
                }
                self.listQueueTypeDWaiting[0].que_current_flag = Constants.Flag.YES
                self.listQueueTypeDWaiting[0].que_call_q_time = NSDate()
                QueueController().updateCurrentQItem(self.listQueueTypeDWaiting[0], uiView : self)
                //print("New Current : Queue No \(self.curQueueTypeD.que_no), Queue Status \(self.curQueueTypeD.que_status), Queue Flag \(self.curQueueTypeD.que_current_flag)")
                self.listQueueTypeDWaiting.removeAtIndex(0)
                self.tableViewTypeDWaiting.reloadData()
                
                self.btnCurrentTypeD.setTitle("\(self.curQueueTypeD.que_tb_type)\(self.curQueueTypeD.que_no.integerValue.format(Constants.DecimalFormat.Queue))", forState: UIControlState.Normal)
                //print("listQueueTypeDWaiting = \(self.listQueueTypeDWaiting.count)")
                //QueueController().instance.pullItems()
                //QueueController().getNoShowQueueListByType(branchId, type:Constants.TableType.D, uiView: self)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    self.callSound("\(self.curQueueTypeD.que_tb_type)\(self.curQueueTypeD.que_no.integerValue.format(Constants.DecimalFormat.Queue))")
                })
            }else{
                self.popupUpdateCurrentQStatus(self.curQueueTypeD,btnCurrent : btnCurrentTypeD, tableNoShow : tableViewTypeDNoShow, isCallFromNextQ : Constants.Flag.YES)
            }
            CustomerController().sendNotiByType(Constants.TableType.D, uiView: self)
        }
    }
    
    
    @IBAction func setCurrentQTypeA() {
        print("Current Type A")
        // Get Current Q Info
        QueueController().getCurrentQueueByType(branchId, type: Constants.TableType.A, uiView: self)
        NSThread.sleepForTimeInterval(0.1)
        if(self.curQueueTypeA.que_status == Constants.QueueStatus.Waiting){
                            
            self.popupUpdateCurrentQStatus(self.curQueueTypeA, btnCurrent: self.btnCurrentTypeA, tableNoShow: self.tableViewTypeANoShow, isCallFromNextQ : Constants.Flag.NO)
        }else if(self.curQueueTypeA.que_status == Constants.QueueStatus.NoShow || self.curQueueTypeA.que_status == Constants.QueueStatus.Completed || self.curQueueTypeA.que_status == Constants.QueueStatus.Cancelled){

            let msg = self.getContentPopup(self.curQueueTypeA, index: 0)
            /*let a = UIAlertController(title: "\(self.curQueueTypeA.que_tb_type)\(self.curQueueTypeA.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
            
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            a.addAction(okButton)
            self.presentViewController(a, animated: true, completion: nil)*/
            status = 0
            queueNo = "\(self.curQueueTypeA.que_tb_type)\(self.curQueueTypeA.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            performSegueWithIdentifier("confirmOrderSegue", sender: msg)
        }
    }
    
    @IBAction func setCurrentQTypeB() {
        print("Current Type B")
        // Get Current Q Info
        QueueController().getCurrentQueueByType(branchId, type: Constants.TableType.B, uiView: self)
        NSThread.sleepForTimeInterval(0.1)
        if(self.curQueueTypeB.que_status == Constants.QueueStatus.Waiting){
            self.popupUpdateCurrentQStatus(self.curQueueTypeB, btnCurrent: self.btnCurrentTypeB, tableNoShow: self.tableViewTypeBNoShow, isCallFromNextQ : Constants.Flag.NO)
        }else if(self.curQueueTypeB.que_status == Constants.QueueStatus.NoShow || self.curQueueTypeB.que_status == Constants.QueueStatus.Completed){

            let msg = self.getContentPopup(self.curQueueTypeB, index: 0)
            
            /*let a = UIAlertController(title: "\(self.curQueueTypeB.que_tb_type)\(self.curQueueTypeB.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
            
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            a.addAction(okButton)
            self.presentViewController(a, animated: true, completion: nil)*/
            status = 0
            queueNo = "\(self.curQueueTypeB.que_tb_type)\(self.curQueueTypeB.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            performSegueWithIdentifier("confirmOrderSegue", sender: msg)
        }
    }

    @IBAction func setCurrentQTypeC() {
        print("Current Type C")
        // Get Current Q Info
        QueueController().getCurrentQueueByType(branchId, type: Constants.TableType.B, uiView: self)
        NSThread.sleepForTimeInterval(0.1)
        if(self.curQueueTypeC.que_status == Constants.QueueStatus.Waiting){
            self.popupUpdateCurrentQStatus(self.curQueueTypeC, btnCurrent: self.btnCurrentTypeC, tableNoShow: self.tableViewTypeCNoShow, isCallFromNextQ : Constants.Flag.NO)
        }else if(self.curQueueTypeC.que_status == Constants.QueueStatus.NoShow || self.curQueueTypeC.que_status == Constants.QueueStatus.Completed){
            let msg = self.getContentPopup(self.curQueueTypeC, index: 0)
            /*
            let a = UIAlertController(title: "\(self.curQueueTypeC.que_tb_type)\(self.curQueueTypeC.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            a.addAction(okButton)
            self.presentViewController(a, animated: true, completion: nil)
*/
            status = 0
            queueNo = "\(self.curQueueTypeC.que_tb_type)\(self.curQueueTypeC.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            performSegueWithIdentifier("confirmOrderSegue", sender: msg)
        }
    }
    
    @IBAction func setCurrentQTypeD() {
        print("Current Type D")
        // Get Current Q Info
        QueueController().getCurrentQueueByType(branchId, type: Constants.TableType.D, uiView: self)
        NSThread.sleepForTimeInterval(0.1)
        if(self.curQueueTypeD.que_status == Constants.QueueStatus.Waiting){
            self.popupUpdateCurrentQStatus(self.curQueueTypeD, btnCurrent: self.btnCurrentTypeD, tableNoShow: self.tableViewTypeDNoShow, isCallFromNextQ : Constants.Flag.NO)
        }else if(self.curQueueTypeD.que_status == Constants.QueueStatus.NoShow || self.curQueueTypeD.que_status == Constants.QueueStatus.Completed){
            let msg = self.getContentPopup(self.curQueueTypeD, index: 0)
            /*
            let a = UIAlertController(title: "\(self.curQueueTypeD.que_tb_type)\(self.curQueueTypeD.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            a.addAction(okButton)
            self.presentViewController(a, animated: true, completion: nil)*/
            status = 0
            queueNo = "\(self.curQueueTypeD.que_tb_type)\(self.curQueueTypeD.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            performSegueWithIdentifier("confirmOrderSegue", sender: msg)
        }
    }
    
    func getContentPopup(queue : Queue, index : Int) -> String{
        var msg:String = ""
        if(queue.que_type == Constants.QueueType.Client){
            msg = "\nCode : \(queue.que_confirm_code)"
        }else{
            msg = "\nCode : - "
        }
        if(queue.que_status == Constants.QueueStatus.Waiting ){
            if(queue.que_current_flag == Constants.Flag.NO){
                msg += "\nWating : \(index+1) Queue(s)"
            }
        }else if(queue.que_status == Constants.QueueStatus.NoShow){
            msg += "\nStatus : No Show"
        }else if(queue.que_status == Constants.QueueStatus.Completed){
            msg += "\nStatus : Completed"
        }else if(queue.que_status == Constants.QueueStatus.Cancelled){
            msg += "\nStatus : Cancelled"
        }
        return msg
    }
    
    func popupUpdateCurrentQStatus(currentQ : Queue, btnCurrent : UIButton, tableNoShow : UITableView, isCallFromNextQ : String){
        var a:UIAlertController
        if(isCallFromNextQ == Constants.Flag.NO){
            let msg = self.getContentPopup(currentQ, index: 0)
            a = UIAlertController(title: "\(currentQ.que_tb_type)\(currentQ.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
        }else{
            let msg = "\nPlease update current queue status.\nQueue No. : \(currentQ.que_tb_type)\(currentQ.que_no.integerValue.format(Constants.DecimalFormat.Queue))\n\(self.getContentPopup(currentQ, index: 0))"
            a = UIAlertController(title: "\(currentQ.que_tb_type)\(currentQ.que_no.integerValue.format(Constants.DecimalFormat.Queue))", message: msg, preferredStyle: .Alert)
        }
        let okButton = UIAlertAction(title: "Complete", style: .Default){
            (action) -> Void in
            self.updateToComplete(currentQ)
            let msg = self.getContentPopup(currentQ, index: 0)
            self.queueNo = "\(currentQ.que_tb_type)\(currentQ.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
            self.performSegueWithIdentifier("confirmOrderSegue", sender: msg)
            //print("Update Current Q Complete : Status is Completed and complete time is updated !! ")
        }
        let noShowButton = UIAlertAction(title: "No Show", style: .Default){
            (action) -> Void in
            self.updateToNoShow(currentQ)
            tableNoShow.reloadData()
            //print("Update Current Q Complete : Status is No Show !! ")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        a.addAction(okButton)
        a.addAction(noShowButton)
        a.addAction(cancelButton)
        self.presentViewController(a, animated: true, completion: nil)
    }
    
    func updateToNoShow(currentQ : Queue){
        if(currentQ.que_tb_type == Constants.TableType.A){
            self.curQueueTypeA.que_status = Constants.QueueStatus.NoShow
            QueueController().updateCurrentQItem(self.curQueueTypeA,uiView : self)
            self.listQueueTypeANoShow.append(currentQ)
        }else if(currentQ.que_tb_type == Constants.TableType.B){
            self.curQueueTypeB.que_status = Constants.QueueStatus.NoShow
            QueueController().updateCurrentQItem(self.curQueueTypeB, uiView : self)
            self.listQueueTypeBNoShow.append(currentQ)
        }else if(currentQ.que_tb_type == Constants.TableType.C){
            self.curQueueTypeC.que_status = Constants.QueueStatus.NoShow
            QueueController().updateCurrentQItem(self.curQueueTypeC, uiView : self)
            self.listQueueTypeCNoShow.append(currentQ)
        }else if(currentQ.que_tb_type == Constants.TableType.D){
            self.curQueueTypeD.que_status = Constants.QueueStatus.NoShow
            QueueController().updateCurrentQItem(self.curQueueTypeD, uiView : self)
            self.listQueueTypeDNoShow.append(currentQ)
        }
    }
    
    func updateToComplete(currentQ : Queue){
        status = 1
        let fromStatus = currentQ.que_status
        currentQ.que_complete_time = NSDate()
        currentQ.que_status = Constants.QueueStatus.Completed
        if(fromStatus == Constants.QueueStatus.Waiting){
            QueueController().updateCurrentQItem(currentQ, uiView : self)
        }else if(fromStatus == Constants.QueueStatus.NoShow){
            QueueController().updateItem(currentQ)
        }
       // performSegueWithIdentifier("confirmOrderSegue", sender: nil)
        
    }
    
    func updateToCancel(currentQ : Queue){
        currentQ.que_status = Constants.QueueStatus.Cancelled
        currentQ.que_cancel_time = NSDate()
        QueueController().updateItem(currentQ)
    }

    @IBAction func refreshViewMethod(sender: AnyObject) {
        //QueueController().instance.pullItems()
        //sleep(2)
        BranchController().getBranchById(self.branchId, uiView:self)
        QueueController().loadAllQueueInfo(self.branchId, uiView: self)
    
       /* print("=================================================================")
        print("1 Count Q Type A Waiting : \(self.listQueueTypeAWaiting.count)")
        
        print("2 Count Q Type A Waiting : \(self.listQueueTypeAWaiting.count)")
        print("=================================================================")
        //self.viewDidAppear(true)
        
        print("3 Count Q Type A Waiting : \(self.listQueueTypeAWaiting.count)")
        print("=================================================================")
        */
    }
    
    func callSound(queueNo : String){
        var soundName : String = ""
        var delaytime : NSTimeInterval = 0.0
        for character in queueNo.characters {
            print("Delay Time : \(delaytime)")
            switch character {
            case "A" :
                soundName = "A"
                delaytime = 3
            case "B" :
                soundName = "B"
                delaytime = 3
            case "C" :
                soundName = "C"
                delaytime = 3
            case "D" :
                soundName = "D"
                delaytime = 3
            case "0" :
                soundName = "0"
                delaytime = 1
            case "1" :
                soundName = "1"
                delaytime = 1
            case "2" :
                soundName = "2"
                delaytime = 1
            case "3" :
                soundName = "3"
                delaytime = 1
            case "4" :
                soundName = "4"
                delaytime = 1
            case "5" :
                soundName = "5"
                delaytime = 1
            case "6" :
                soundName = "6"
                delaytime = 1
            case "7" :
                soundName = "7"
                delaytime = 1
            case "8" :
                soundName = "8"
                delaytime = 1
            case "9" :
                soundName = "9"
                delaytime = 1
            default: print("end")
                
            }
            
            print("soundName : \(soundName)")
            var soundURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: "m4a")
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL!)
            }catch _ {
                print("Cannot play sound")
            }
            audioPlayer.play()
            
            NSThread.sleepForTimeInterval(delaytime)
        }
        var endSoundURL = NSBundle.mainBundle().URLForResource("end", withExtension: "m4a")
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: endSoundURL!)
        }catch _{
                print("Cannot play sound")
        }
        audioPlayer.play()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "confirmOrderSegue" {
            let navVC = segue.destinationViewController as! UINavigationController
            let orderListVC = navVC.topViewController as! OrderListViewController
            orderListVC.queueNo = queueNo
            if sender != nil{
                let detail = sender as! String
                orderListVC.queueInfo = detail
            }
            orderListVC.status = status
        }
    }
    

}