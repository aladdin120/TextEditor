import UIKit

class ViewController: UIViewController {
    
    private var mainTextView = UITextView()
    private var clearButton  = UIButton()
    private var imageButton = UIButton()
    private var mainImageView = UIImageView()
    
    private let start = "Write something"
    private var isFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Text Editor"
        view.backgroundColor = .white
        
        createTextView()
        createResetButton()
        createImageButton()
        createImageView()
        
        createTextViewConstraint()
    }
    
    
    func createTextView() {
        mainTextView.text = start
        mainTextView.font = UIFont.systemFont(ofSize: 20, weight:  .medium)
        mainTextView.backgroundColor = .white
        mainTextView.layer.borderColor = UIColor.black.cgColor
        mainTextView.layer.borderWidth = 0.5
        mainTextView.layer.cornerRadius = 5
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.delegate = self
        self.view.addSubview(mainTextView)
    }
    
    func createImageView() {
        mainImageView.layer.borderColor = UIColor.black.cgColor
        mainImageView.layer.borderWidth = 0.5
        mainImageView.layer.cornerRadius = 5
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainImageView)
    }
    
    func createTextViewConstraint() {
        mainTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mainTextView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        mainImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mainImageView.topAnchor.constraint(equalTo: mainTextView.bottomAnchor, constant: 10).isActive = true
    }
    
    func createResetButton() {
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(resetCounter), for: .touchUpInside)
        clearButton.setTitleColor(.blue, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: clearButton)
    }
    
    func createImageButton() {
        imageButton.setTitle("Image", for: .normal)
        imageButton.addTarget(self, action: #selector(tappedImageButton), for: .touchUpInside)
        imageButton.setTitleColor(.blue, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainTextView.resignFirstResponder()
        }
    

    
    @objc func resetCounter() {
        mainTextView.text = start
    }
    
    @objc func tappedImageButton() {
        showImageController()
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showImageController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isFirstTime {
            mainTextView.text = ""
            isFirstTime = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if mainTextView.text.isEmpty {
            isFirstTime = true
            mainTextView.text = start
        }
    }
}
