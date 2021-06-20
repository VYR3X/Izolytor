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
	/// Загрузить видео
	func loadVideo()
	/// Вернуться назад
	func didTapBackButton()
}

/// Ячейка содержащая вью c "YouTube плеером"
final class YouTubeTableViewCell: UITableViewCell {

	/// Делегат ячейки youtube вью
	var delegate: YouTubeTableViewCellDelegate?

	private let youtubeView: YTPlayerView = {
		let view = YTPlayerView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = LightPalette().color(.lightBlue)
		return view
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		loadVideoIntoYouTubeView()
	}

	private func setupConstraints() {
		contentView.addSubview(youtubeView)

		NSLayoutConstraint.activate([
			youtubeView.topAnchor.constraint(equalTo: topAnchor),
			youtubeView.bottomAnchor.constraint(equalTo: bottomAnchor),
			youtubeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			youtubeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}

	private func loadVideoIntoYouTubeView() {
		youtubeView.load(withVideoId: "jOk_6pXi2Vs")
//		delegate?.loadVideo()
	}

//	@objc private func tapOnLeftButton(sender: UIButton) {
//		print("вернуться назад")
//		delegate?.didTapBackButton()
//	}
}

