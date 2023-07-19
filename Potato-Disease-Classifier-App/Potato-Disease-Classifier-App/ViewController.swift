//
//  SecondVC.swift
//  Potato-Disease-Classifier-App
//
//  Created by TanjilaNur-00115 on 18/7/23.
//

import UIKit
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named:"early_blight1")
//        imageView.image = UIImage(named:"late_blight1")
        imageView.image = UIImage(named:"healthy1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
//        PredictDisease(image: UIImage(named:"early_blight1"))
//        PredictDisease(image: UIImage(named:"late_blight1"))
        PredictDisease(image: UIImage(named:"healthy1"))
        
    }

    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width-40,
            height: view.frame.size.width-40)
        label.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top+(view.frame.size.width-40)+10,
            width: view.frame.size.width-40,
            height: 100
        )
    }

    func PredictDisease(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?
                .toCVPixelBuffer() else {
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try PotatoClassifierMlModel(configuration: config)
            let input = PotatoClassifierMlModelInput(image: buffer)

            let output = try model.prediction(input: input)
            print(output)
            label.text = output.classLabel
            
        }
        catch {
            print(error.localizedDescription)
            
        }
         
    }

}
