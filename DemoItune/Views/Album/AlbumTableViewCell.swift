//
//  TopicTableViewCell.swift
//  DemoItune
//
//  Created by Quan Nguyen on 8/28/20.
//  Copyright © 2020 quannh. All rights reserved.
//

import UIKit

protocol AlbumTableViewCellDelegate {
    func offsetDidChange(indexPath: IndexPath, contentOffset: CGPoint)
}

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var delegate: AlbumTableViewCellDelegate?
    var indexPath: IndexPath = IndexPath()
    var albumCellArray: [Cell] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView()
        registerCollectionViewCell()
    }
    
    func configCell(topic: Topic, indexPath: IndexPath, contentOffset: CGPoint) {
        self.indexPath = indexPath
        albumCellArray = topic.cell
        albumCollectionView.contentOffset = contentOffset
        topicNameLabel.text = topic.title
        topicNameLabel.textColor = topic.title == "Hots now" ? UIColor(named: "tintColor") : .black
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCollectionView() {
        albumCollectionView.dataSource = self
        albumCollectionView.delegate = self
    }
    func registerCollectionViewCell() {
        let nibCollectionViewCell = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        albumCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: "AlbumCollectionViewCell")
    }
    override func prepareForReuse() {
        albumCollectionView.reloadData()
    }
}

extension AlbumTableViewCell: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = albumCollectionView.contentOffset
        delegate?.offsetDidChange(indexPath: indexPath, contentOffset: offset)
    }
}

extension AlbumTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.configCell(cell: albumCellArray[indexPath.row])
        return cell
    }
    
}