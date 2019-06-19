//
//  ViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 11/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//
//


import UIKit

class MemeEditorViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate  {
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var camButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
      @IBOutlet weak var cancelButton: UIBarButtonItem!
     @IBOutlet weak var navBar: UINavigationBar!
    
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white,
            NSAttributedString.Key.strokeColor.rawValue : UIColor.black,
            NSAttributedString.Key.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth.rawValue: -4.0,
            ]  as! [NSAttributedString.Key : Any]
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextField(tf: topText, text: "TOP")
        self.setupTextField(tf: bottomText, text: "BOTTOM")
        if(imagePickerView.image == nil){
            shareVisibilty(visibility : false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        camButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func presentPickerViewController(SourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = SourceType
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        if ((sender as AnyObject).tag==1){
            presentPickerViewController(SourceType: .camera)
        }
        else {
            
            
            presentPickerViewController(SourceType: .photoLibrary)
        }
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            shareVisibilty(visibility : true)
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        if imagePickerView.image == nil {
            shareVisibilty(visibility : false)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let memedImage = generateMemed()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { _, success, _, error in
            if let Error = error {
                let alert = UIAlertController(title: "Warning", message: Error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            if success {
                self.Save()
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    func shareVisibilty(visibility : Bool){
        shareButton.isEnabled = visibility
    }
    
   
    
    func bottomToolBarVisibilty(visibility : Bool){
        bottomToolBar.isHidden = !visibility
    }
    
    func hideTopAndBottomBars(_ hide: Bool) {
        navBar.isHidden = hide
        bottomToolBar.isHidden = hide
    }
    func generateMemed() -> UIImage {
      
        hideTopAndBottomBars(false)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let Image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideTopAndBottomBars(true)
        
        return Image
    }
    
    func Save() {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemed())
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    // KeyBord Functions
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomText.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification)  ->CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue 
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func navBarVisibilty(visibility : Bool){
        navBar.isHidden = !visibility
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

