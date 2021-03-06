//
//  MessageThreadsTableViewController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		messageThreadController.fetchMessageThreads { (error) -> (Void) in
			if let error = error {
				print("error: viewDidAppear",error)
			}
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	
	@IBAction func messageBoardTextFieldDidEndOnExit(_ sender: UITextField) {
		
		guard let title = sender.text else {
			return
		}
		messageThreadController.CreateMessageThread(title: title) { (error) in
			if let error = error {
				print("error: \(error)")
				return
			}
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThreadController.messageThreads.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MesseageBoardCell", for: indexPath)
		
		
		cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "MessageThreadDetailSegue" {
			guard let vc = segue.destination as? MessageThreadDetailTableViewController,
				let cell = sender as? UITableViewCell else {
				print("errro: prepare(for: segue")
				return
			}
			
			guard let indexpath = tableView.indexPath(for: cell) else { return }
			vc.meseageThreadController = messageThreadController
			vc.messageThread = messageThreadController.messageThreads[indexpath.row]
			
			
		}
	}
	
	let messageThreadController = MessageThreadController()
}
