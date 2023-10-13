//
//  UIViewController+Photos.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Photos
import UIKit

protocol ImagePickerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate {}

extension ImagePickerDelegate where Self: UIViewController {
    func requestPhotoLibraryAuthorization() {
        showActivityIndicator()
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    self.presentImagePicker()
                }
            }
        case .restricted, .denied:
            showAlertToOpenPhotoPermissionsSettings()
        case .limited:
            presentImagePicker()
        case .authorized:
            presentImagePicker()
        @unknown default:
            hideActivityIndicator()
            return
        }
    }

    func presentImagePicker() {
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true) {
                self.hideActivityIndicator()
            }
        }
    }

    func showAlertToOpenPhotoPermissionsSettings() {
        let alertController = UIAlertController(title: LocalizedStrings.photoPermissionsAlertTitle,
                                                message: LocalizedStrings.photoPermissionsAlertText,
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: LocalizedStrings.photoPermissionAlertSettingsButton,
                                           style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl)
            else { return }
            UIApplication.shared.open(settingsUrl)
        }
        let cancelAction = UIAlertAction(title: LocalizedStrings.photoPermissionsAlertCancelButton,
                                         style: .default,
                                         handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        hideActivityIndicator()
        present(alertController, animated: true)
    }
}
