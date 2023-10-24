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
    @Published var videoURL: URL?
    @Published var isVideoEnded = false

    // ビデオの選択肢を持つ配列
    let videoOptions = [
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!,
    ]

    init() {
        // 初期ビデオを設定
        videoURL = videoOptions[0]
    }

    func selectVideo(at index: Int) {
        videoURL = videoOptions[index]
        isVideoEnded = false
    }
}

struct VideoPlayerView: View {
    @StateObject private var viewModel = VideoViewModel()
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            if let videoURL = viewModel.videoURL {
                VideoPlayer(player: player)
                    .onAppear {
                        setupPlayer(with: videoURL)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                        viewModel.isVideoEnded = true
                    }
            }

            if viewModel.isVideoEnded {
                ForEach(0..<viewModel.videoOptions.count, id: \.self) { index in
                    Button(action: {
                        viewModel.selectVideo(at: index)
                    }) {
                        Text("Video \(index + 1)")
                    }
                }
            }
        }
        .onChange(of: viewModel.videoURL) {
            _, newVideoURL in
            if let newURL = newVideoURL {
                setupPlayer(with: newURL)
            }
        }
    }

    private func setupPlayer(with url: URL) {
        print(url)
        player = AVPlayer(url: url)
        player?.play()
    }
}
