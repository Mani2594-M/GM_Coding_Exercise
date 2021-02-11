//
//  ResultCell.swift
//  GM_Coding_Exercise
//
//  Created by Mani V on 2/11/21.
//

import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(with artistName: String, trackName: String, trackPrice: Double, primaryGenre: String, releaseDate: String) {
        artistNameLabel.text = artistName
        trackNameLabel.text = trackName
        primaryGenreLabel.text = primaryGenre
        trackPriceLabel.text = String(trackPrice)
        releaseDateLabel.text = String(releaseDate)
    }
}
