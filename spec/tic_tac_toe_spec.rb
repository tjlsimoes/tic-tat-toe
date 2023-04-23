require "./lib/tic-tac-toe-adapted-solution"

describe Game do
  subject(:game) { described_class.new(HumanPlayer, HumanPlayer)}

  describe "#place_player_marker" do


    context "when game is initialized" do
      before do
        player1 = game.current_player
        allow(player1).to receive(:select_position!).and_return(5)
        allow(game).to receive(:puts)
      end

      it "permits player 1 (X) to choose position 5" do
        player1 = game.current_player
        game.place_player_marker(player1)
        board_array = game.instance_variable_get(:@board)
        expect(board_array[5]).to eq("X")
      end
    end

    context "when game is mid-way" do
      before do
        board = [nil, "X", "O", "X", "0", nil, nil, nil, nil, nil]
        game.instance_variable_set(:@board, board)
        player1 = game.current_player
        allow(player1).to receive(:select_position!).and_return(5)
        allow(game).to receive(:puts)
      end

      it "permits player 1 (X) to choose position 5" do
        player1 = game.current_player
        game.place_player_marker(player1)
        board_array = game.instance_variable_get(:@board)
        # p board_array
        expect(board_array[5]).to eq("X")
      end
    end

    context "when game is ending" do
      before do
        board = [nil, "X", "O", "X", "0", nil, nil, "X", "O", nil]
        game.instance_variable_set(:@board, board)
        player1 = game.current_player
        allow(player1).to receive(:select_position!).and_return(5)
        allow(game).to receive(:puts)
      end

      it "permits player 1 (X) to choose position 5" do
        player1 = game.current_player
        game.place_player_marker(player1)
        board_array = game.instance_variable_get(:@board)
        # p board_array
        expect(board_array[5]).to eq("X")
      end
    end
  end

end