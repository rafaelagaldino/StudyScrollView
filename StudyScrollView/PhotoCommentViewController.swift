//
//  PhotoCommentViewController.swift
//  StudyScrollView
//
//  Created by Rafaela Galdino on 17/12/19.
//  Copyright © 2019 Rafaela Galdino. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!

    var photoName: String?
    var photoIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoName = photoName {
            self.imageView.image = UIImage(named: photoName)
        }
        
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillShow(_:)),
          name: UIResponder.keyboardWillShowNotification,
          object: nil)

        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillHide(_:)),
          name: UIResponder.keyboardWillHideNotification,
          object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, let viewController = segue.destination as? ZoomedPhotoViewController, id == "zooming" {
            viewController.photoName = photoName
        }
    }
}

extension PhotoCommentViewController {
    @IBAction func hideKeyboard(_ sender: AnyObject) { // Descarte de teclado, para descartá-lo ao clicar em Enter é necessário clicar com o botão direito no UITextField e marcar a opção Primary Action Triggered
      nameTextField.endEditing(true)
    }
    
    @IBAction func openZoomingController(_ sender: AnyObject) {
      self.performSegue(withIdentifier: "zooming", sender: nil)
    }
}

extension PhotoCommentViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }

    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
      guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
      let adjustmentHeight = (keyboardFrame.cgRectValue.height + 20) * (show ? 1 : -1)
      scrollView.contentInset.bottom += adjustmentHeight
      scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
    }
}
