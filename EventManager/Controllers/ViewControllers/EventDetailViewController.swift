//
//  EventDetailViewController.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var eventNameLabel: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = eventNameLabel.text, !title.isEmpty else { return }
        let dateStamp = eventDatePicker.date
        
        if let event = event {
            EventController.shared.updateEvent(event: event, newTitle: title, newDate: dateStamp)
        } else {
            let newEvent = Event(title: title, date: dateStamp)
            EventController.shared.createEvent(event: newEvent)
        }
        navigationController?.popViewController(animated: true)
    }
  
    func updateViews() {
        guard let event = event else { return }
        eventNameLabel.text = event.title
        eventDatePicker.date = event.date ?? Date()
    }
}
