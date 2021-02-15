//
//  AllFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit

class AllFlashcardsViewController: UIViewController {

    var flashcards: [Flashcard] = []//List of loaded flashcards
    var flashcardToEdit: Flashcard?
    
    let imageViewAddbutton = UIImageView()
    
    var flashcardsTableView: UITableView!
    let flashcardsTableViewCellIdentifier = "flashcardsTableViewCellIdentifier"

    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hi im working")
        title = "Wszystkie fiszki"
        view.backgroundColor = Colors.FATGbackground
        navigationController?.navigationBar.tintColor = Colors.FATGpurple
        
        createAddButton()
        
        loadData()
        
        configureFlashcardsTableView()
        view.addSubview(flashcardsTableView)
        flashcardsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25 ).isActive = true
        flashcardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        flashcardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        flashcardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageViewAddbutton.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageViewAddbutton.isHidden = false
    }
    
    func createAddButton(){
        imageViewAddbutton.image = UIImage(systemName: "plus.circle.fill")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonAction))
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(imageViewAddbutton)
        imageViewAddbutton.clipsToBounds = true
        imageViewAddbutton.translatesAutoresizingMaskIntoConstraints = false
        imageViewAddbutton.isUserInteractionEnabled = true
        imageViewAddbutton.addGestureRecognizer(tapGestureRecognizer)

        imageViewAddbutton.tintColor = Colors.FATGpink
        NSLayoutConstraint.activate([
            imageViewAddbutton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16),
            imageViewAddbutton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12),
            imageViewAddbutton.heightAnchor.constraint(equalToConstant: 45),
            imageViewAddbutton.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        
    }
    
    @objc
    func addButtonAction() {
        
        let addVC = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "addFlashcard") as! AddFlashcardsViewController
        

        addVC.allFlashcardsViewController = self
        
        navigationController?.showDetailViewController(addVC, sender: true)

    }

    func loadData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            flashcards = try context.fetch(Flashcard.fetchRequest())
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        DispatchQueue.main.async {
            self.flashcardsTableView.reloadData()
        }
        
    }
    func configureFlashcardsTableView(){
        
        flashcardsTableView = UITableView()
        //set row height
        //flashcardsTableView.rowHeight = 100 //UITableView.automaticDimension
        //flashcardsTableView.estimatedRowHeight = 90
        //register cells
        flashcardsTableView.register(FlashcardsTableViewCell.self, forCellReuseIdentifier: flashcardsTableViewCellIdentifier)
        //set contraits
        flashcardsTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setFlashcardsTableViewDelegates()
        
        flashcardsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        flashcardsTableView.showsVerticalScrollIndicator = false
        
    
        flashcardsTableView.backgroundColor = .clear

    }
    
//    func backFromEditFlashcardController(data: Flashcard!){
//        print("Data received: \(data)")
//        flashcardToEdit = data
//
//    }
    
    func backFromAddingNewFlashcard( data: Flashcard!){
        flashcards.append(data)
        flashcardsTableView.reloadData()
    }

}


extension AllFlashcardsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: flashcardsTableViewCellIdentifier, for: indexPath) as? FlashcardsTableViewCell else {
            fatalError("Bad Instance")
        }
        cell.selectionStyle = .none
        let flashcard = flashcards[indexPath.row]
        cell.wordLabel.text = flashcard.word
        cell.translationLabel.text = flashcard.translation
        cell.pronunciationLabel.text = "wym. /\(flashcard.pronunciation ?? "  ")/"
        cell.meaningLabel.text = flashcard.meaning
        cell.exampleLabel.text = flashcard.example
       


        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: flashcardsTableViewCellIdentifier, for: indexPath) as? FlashcardsTableViewCell else {
            fatalError("Bad Instance")
        }

//        let flashcard = flashcards[indexPath.row]
//       print(flashcard.word)
        if selectedRowIndex != indexPath.row {
               self.thereIsCellTapped = true
               self.selectedRowIndex = indexPath.row
            
           }
           else {
               // there is no cell selected anymore
               self.thereIsCellTapped = false
               self.selectedRowIndex = -1
           }

        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let flashcard = flashcards[indexPath.row]
        
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            var height:  CGFloat = 190
            
            height = ( flashcard.meaning == "" ) ? ( height - 15 ) : ( height + CGFloat(( 15 * ( flashcard.meaning!.count / 35 ) )))
            height = ( flashcard.example == "" ) ? ( height - 15 ) : ( height + CGFloat(( 15 * ( flashcard.example!.count / 35 ) )))
            
//            if ( flashcard.meaning == "" ) {
//                height -= 15
//            } else {
//                height += CGFloat(( 15 * ( flashcard.meaning!.count / 35 ) ))
//            }
//
//            if ( flashcard.example == "" ) {
//                height -= 15
//            } else {
//                height += CGFloat(( 15 * ( flashcard.example!.count / 35 ) ))
//            }
            //previous one:
//            if ( flashcard.meaning?.count ?? 0 > 35 ) { height += 15 }
//            if (flashcard.meaning?.count ?? 0 > 70 ) { height += 15 }
//            if (flashcard.meaning?.count ?? 0 > 105 ) { height += 15 }
//
//            if ( flashcard.example?.count ?? 0 > 35 ) { height += 15 }
//            if (flashcard.example?.count ?? 0 > 70 ) { height += 15 }
//            if (flashcard.example?.count ?? 0 > 105 ) { height += 15 }
//

            
            return height
        }

        return 90
    }

    func setFlashcardsTableViewDelegates(){
        flashcardsTableView.delegate = self
        flashcardsTableView.dataSource = self
    }


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Usuń") { [self] (action, view, completion) in
        
        guard let appDelegate =
                      UIApplication.shared.delegate as? AppDelegate else {
                      return
                    }
        
                    let managedContext = appDelegate.persistentContainer.viewContext
        
                    let flashcard = flashcards[indexPath.row]
                    managedContext.delete(flashcard)
        
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                    }
        
                    flashcards.remove(at: indexPath.row)
                    flashcardsTableView.deleteRows(at: [indexPath], with: .fade)
        
          completion(true)
      }

        let muteAction = UIContextualAction(style: .normal, title: "Edytuj") { [self] (action, view, completion) in

        let editFlashcards = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "editFlashcard") as! EditFlashcardsViewController
        
        flashcardToEdit = self.flashcards[indexPath.row]

        editFlashcards.allFlashcardsViewController = self
        editFlashcards.flashcardToEdit = self.flashcardToEdit



   
        
        
        self.navigationController?.showDetailViewController(editFlashcards, sender: true)


        completion(true)
      }
        //muteAction.image = UIImage(systemName: "pencil")
        muteAction.backgroundColor = Colors.FATGpurple
        //deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = Colors.FATGpink
      return UISwipeActionsConfiguration(actions: [deleteAction, muteAction])
    }
    
   
    
    
}
