//
//  YouTubeTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import youtube_ios_player_helper
import UIKit

/// Делегат ячейки вью c "YouTube плеером"
protocol YouTubeTableViewCellDelegate {
	func loadVideo()
}

/// Ячейка содержащая вью c "YouTube плеером"
final class YouTubeTableViewCell: UITableViewCell {

	/// Делегат ячейки youtube вью
	var delegate: YouTubeTableViewCellDelegate?

	private let headerLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Изолятор"
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .black
		label.backgroundColor = .clear
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	private let youtubeView: YTPlayerView = {
		let view = YTPlayerView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = LightPalette().color(.lightBlue)
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		loadVideoIntoYouTubeView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupConstraints() {
		contentView.addSubviews(headerLabel, youtubeView)

		NSLayoutConstraint.activate([
			headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
			headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			youtubeView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
			youtubeView.bottomAnchor.constraint(equalTo: bottomAnchor),
			youtubeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			youtubeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}

	private func loadVideoIntoYouTubeView() {
		youtubeView.load(withVideoId: "jOk_6pXi2Vs")
//		delegate?.loadVideo()
	}
}

