//
//
// VideoPlayer.swift
// mirupu
//
// Created by hulk510 on 2023/10/24
// Copyright © 2023 gotoharuka . All rights reserved.
//

import SwiftUI
import AVKit

class VideoViewModel: ObservableObject {
    @Published var isVideoEnded = false

    // ビデオの選択肢を持つ配列
    @Published var videoData: VideoData = VideoData(mainVideoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
                                                    choice1: .init(title: "選択肢１", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!),
                                                    choice2: .init(title: "選択肢2", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)
    )
}

struct VideoPlayerView: View {
    @StateObject private var viewModel = VideoViewModel()
    @State private var player: AVPlayer?
    @State private var isFinish: Bool = false

    var body: some View {
        VStack {
            if viewModel.isVideoEnded {
                Text("Choose a video:")
                Button(viewModel.videoData.choice1.title) {
                    setupPlayer(with: viewModel.videoData.choice1.videoURL, isLast: true)
                }
                Button(viewModel.videoData.choice2.title) {
                    setupPlayer(with: viewModel.videoData.choice2.videoURL, isLast: true)
                }
            } else {
                VideoPlayer(player: player)
                    .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                        if isFinish {
                            setupPlayer(with: viewModel.videoData.mainVideoURL)
                        } else {
                            viewModel.isVideoEnded = true
                        }
                    }
            }
        }
        .onAppear {
            setupPlayer(with: viewModel.videoData.mainVideoURL)
        }
    }

    private func setupPlayer(with url: URL, isLast: Bool = false) {
        player = AVPlayer(url: url)
        player?.play()
        viewModel.isVideoEnded = false
        isFinish = isLast
    }
}
