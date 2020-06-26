//
//  TableViewCell.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import UIKit

class FetchQoutesCell: UITableViewCell {
    @IBOutlet weak var authorName:UILabel!
    @IBOutlet weak var quotes:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FetchQoutesCell :FetchQoutesCellView{
    func displayAuthor(authorName: String) {
        self.authorName.text = authorName
    }
    
    func displayQoutes(qoutes: String) {
        self.quotes.text = qoutes
    }
    
    
}
