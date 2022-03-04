//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Mehdi MMS on 04/03/2022.
//

import UIKit

protocol EventTableViewCellDelegate: AnyObject {
    func eventCellButtonTapped(_ sender: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    weak var delegate: EventTableViewCellDelegate?
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.eventCellButtonTapped(self)
        }
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.title
        let checked = UIImage(systemName: "clock.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .default))
        let unchecked = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .default))
        if event.isDone {
            completionButton.setBackgroundImage(checked, for: .normal)
        } else {
            completionButton.setBackgroundImage(unchecked, for: .normal)
        }
    }
}


