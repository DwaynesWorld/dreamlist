//
//  ItemDetailsVC.swift
//  Dreamlister
//
//  Created by Kyle Thompson on 11/20/16.
//  Copyright © 2016 KTinc. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var typeField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var imageBox: UIImageView!

    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        titleField.delegate = self
        priceField.delegate = self
        detailsField.delegate = self
        typeField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //generateTestData()
        getStores()
        if itemToEdit != nil { loadItemData() }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let pic = Image(context: context)
        let itemType = ItemType(context: context)
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        if let type = typeField.text {
            itemType.type = type
            item.toItemType = itemType
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        if let img = imageBox.image {
            pic.image = img
            item.toImage = pic
        }
        
        app.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            imageBox.image = item.toImage?.image as? UIImage
            typeField.text = item.toItemType?.type
            
            if let store = item.toStore {
                var i = 0
                repeat {
                    let s = stores[i]
                    if s.name == store.name {
                        storePicker.selectRow(i, inComponent: 0, animated: true)
                        break
                    }
                    i += 1
                } while (i <= stores.count)
            }
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageBox.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trashPressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            app.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func generateTestData() {
        let store1 = Store(context: context)
        store1.name = "Porsche of Houston"
        
        let store2 = Store(context: context)
        store2.name = "Houston Realty"
        
        let store3 = Store(context: context)
        store3.name = "Watch Mart"
        
        let store4 = Store(context: context)
        store4.name = "Adidas"
        
        let store5 = Store(context: context)
        store5.name = "Apple"
        
        let store6 = Store(context: context)
        store6.name = "Amazon"
        
        app.saveContext()
    }
}









