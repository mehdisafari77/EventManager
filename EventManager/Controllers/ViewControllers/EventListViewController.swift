//
//  EventListViewController.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewLabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewLabel.delegate = self
        tableViewLabel.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewLabel.reloadData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EventController.shared.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.eventCell, for: indexPath) as?
                EventTableViewCell else { return UITableViewCell() }
        let event = EventController.shared.events[indexPath.row]
       
        cell.delegate = self
        cell.event = event
        
        return cell
    }
    
    // support edit table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.detailSegue {
           guard let indexPath = tableViewLabel.indexPathForSelectedRow,
                 let destination = segue.destination as? EventDetailViewController else { return }
        
            let event = EventController.shared.events[indexPath.row]
            destination.event = event
        }
    }

}

extension EventListViewController: EventTableViewCellDelegate {
    func eventCellButtonTapped(_ sender: EventTableViewCell) {
        guard let event = sender.event else { return }
        EventController.shared.toggleIsDone(event: event)
        sender.updateViews()
    }
}
