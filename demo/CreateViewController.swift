//
//  CreateViewController.swift
//  demo
//
//  Created by macbookpro on 14/11/2021.
//

import UIKit

class CreateViewController: UIViewController {
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    public static let datePickerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = .current
        return formatter
    }()
    
    public static let timePickerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        formatter.locale = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Group"
        view.backgroundColor = .systemBackground
        
        
        creeatButton.addTarget(self,
                               action: #selector(createButtonTapped),
                               for: .touchUpInside)
        
        
        nameField.delegate = self
        maxField.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissSelf))
        // Add subviews
        
        view.addSubview(nameField)
        view.addSubview(minField)
        view.addSubview(maxField)
        view.addSubview(creeatButton)
        view.addSubview(datePickerField)
        view.addSubview(imageView)
        view.addSubview(companynameLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = view.bounds
        
        
        nameField.frame = CGRect(x: 30,
                                 y: 20,
                                 width: view.width-100,
                                 height: 52)
        minField.frame = CGRect(x: 30,
                                y: nameField.bottom+20,
                                width: view.width/3,
                                height: 52)
        maxField.frame = CGRect(x: minField.width+50,
                                y: nameField.bottom+20,
                                width: view.width/3,
                                height: 52)
        datePickerField.frame = CGRect(x: 30,
                                       y: maxField.bottom + 30,
                                       width: view.width-100,
                                       height: 52)
        creeatButton.frame = CGRect(x: 30,
                                    y: imageView.bottom + 20,
                                    width: view.width-60,
                                    height: 52)
        imageView.frame = CGRect(x: 10,
                                 y: datePickerField.bottom + 20,
                                 width: view.width-20,
                                 height: 300)
        
    }
    
    @objc private func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    private let companynameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Tennis Club Ltd."
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .sentences
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.placeholder = "Group Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "map")
        return imageView
    }()
    
    private let minField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .sentences
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.placeholder = "Min"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let maxField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .sentences
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.placeholder = "Max"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let datePickerField: UITextField = {
        let field = UITextField()
        let picker: UIDatePicker
        let currentDate = createCurrentDate()
        picker = createPicker(field)
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.text = "\(currentDate)"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.inputView = picker
        addDoneButton(field)
        return field
    }()
    
    private let creeatButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y:0, width: 200, height: 50))
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return button
    }()
    
    private static func createPicker(_ field: UITextField) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        return picker
    }
    
    private static func addDoneButton(_ field: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDone))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneButton)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        field.inputAccessoryView = doneToolbar
    }
    
    @objc private func didTapDone() {
        self.view.endEditing(true)
        
    }
    
    @objc private func createButtonTapped() {
        nameField.resignFirstResponder()
        minField.resignFirstResponder()
        maxField.resignFirstResponder()
        datePickerField.resignFirstResponder()
        
        guard let name = nameField.text, let max = Int(maxField.text!), let min = Int(minField.text!),
              !name.isEmpty, let id = createGroupId(), max > 0, min > 0, min <= max else {
                  print("error")
                  return
              }
        
        let stringMax: String = String(max)
        DatabaseManager.shared.insertGroup(with: Group(id: id,
                                                       max: stringMax,
                                                       name: name,
                                                       createUser: User.username))
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension CreateViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameField {
            minField.becomeFirstResponder()
        }
        else if textField == minField{
            maxField.becomeFirstResponder()
        }
        else if textField == maxField {
            datePickerField.becomeFirstResponder()
        }
        else if textField == datePickerField {
            createButtonTapped()
        }
        return true
    }
    
    private func createGroupId() -> String? {
        //time, groupname, max
        let dateString = Self.dateFormatter.string(from: Date())
        guard let name = nameField.text, let max = maxField.text,
              !name.isEmpty, !max.isEmpty else {
                  return nil
              }
        
        let newIdentifier = "\(name)_\(max)_\(dateString)"
        
        print("created ID: \(newIdentifier)")
        return newIdentifier
    }
    
    private static func createCurrentDate() -> String {
        let currentDate = Self.datePickerFormatter.string(from: Date())
        return currentDate
    }
    
}
