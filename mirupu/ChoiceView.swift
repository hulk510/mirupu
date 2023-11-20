//
//
// ChoiceView.swift
// mirupu
//
// Created by hulk510 on 2023/10/25
// Copyright © 2023 gotoharuka . All rights reserved.
//

import SwiftUI

struct ChoiceView: View {
    var title: String
    var choice1: Choice
    var choice2: Choice
    @State private var selectChoiceColor: Color = .black
    @State private var selectChoice: Choice? = .none
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(.title).bold()
                .padding()
            HStack(spacing: 32) {
                choiceButton(choice: choice1, background: .red)
                choiceButton(choice: choice2, background: .blue)
            }
            Spacer()
            Text("残り5秒!")
                .font(.title2)
            HStack(spacing: 24) {
                Button("未回答にする") {
                    print("未回答")
                }
                .buttonStyle(.bordered)
                .tint(.black)
                if let yourChoice = selectChoice {
                    Button("\(yourChoice.title)を選択する") {
                        print("\(yourChoice.title)を選択しました。")
                    }
                    .bold()
                    .buttonStyle(.borderedProminent)
                    .tint(selectChoiceColor)
                }
            }
            Spacer()
        }
    }

    func choiceButton(choice: Choice, background: Color) -> some View {
        Button(action: {
            selectChoice = choice
            selectChoiceColor = background
            // select Choice2
            // navigate ResultView
        }) {
            VStack {
                Text("A")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                Text(choice.title)
                    .font(.title2)
                    .tint(.white)
                    .bold()
            }
        }
        .frame(width: 160, height: 200)
        .background(background)
        .mask(RoundedRectangle(cornerRadius: 5).fill(.black))
        .shadow(radius: 4)
    }
}

#Preview {
    ChoiceView(title: "暇な時何する？", choice1: .init(title: "寝る"), choice2: .init(title: "スマホいじる"))
}
