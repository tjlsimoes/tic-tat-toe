require "./lib/tic-tac-toe-adapted-solution"

describe Game do
  subject(:game) { described_class.new(HumanPlayer, HumanPlayer)}

  describe "#free_positions" do
    context "when game is initialized" do
      it "returns array with 1 up to 9" do
        array = [1,2,3,4,5,6,7,8,9]
        expect(game.free_positions).to eq(array)
      end
    end

    context "when game is midway" do
      before do
        board = [nil, "X", "O", "X", "0", nil, nil, nil, nil, nil]
        game.instance_variable_set(:@board, board)
      end

      it "returns array with 5 up to 9" do
        array = [5,6,7,8,9]
        expect(game.free_positions).to eq(array)
      end
    end

    context "when game is ending" do
      before do
        board = [nil, "X", "O", "X", "0", nil, nil, "X", "O", nil]
        game.instance_variable_set(:@board, board)
      end

      it "returns array with 5, 6, 9" do
        array = [5,6,9]
        expect(game.free_positions).to eq(array)
      end
    end
  end

  describe "Player#select_position!" do

    context "when game is initialized and input valid" do
      before do
        player1 = game.current_player
        allow(game).to receive(:print_board)
        allow(player1).to receive(:print)
        allow(player1).to receive(:gets).and_return("5")
        board = [1,2,3,4,5,6,7,8,9]
        allow(game).to receive(:free_positions).and_return(board)
      end

      it "does not return puts statement" do
        player1 = game.current_player
        player1.select_position!
        message = "Position 5 is not available. Try again."
        expect(game).to_not receive(:puts).with(message)
      end

      it "returns user input (5)" do
        player1 = game.current_player
        result = player1.select_position!
        expect(result).to eq(5)
      end
    end

    context "user input invalid followed by valid one" do
      before do
        player1 = game.current_player
        allow(game).to receive(:print_board)
        allow(player1).to receive(:print)
        allow(player1).to receive(:gets).and_return("5")
        board = [1,2,3,4,6,7,8,9]
        allow(game).to receive(:free_positions).and_return(board, [5])
      end

      context "user input not available" do
        it "returns puts statement once" do
          player1 = game.current_player
          message = "Position 5 is not available. Try again."
          expect(player1).to receive(:puts).with(message).once
          player1.select_position!
        end
      end

      context "10 as user input" do
        before do
          player1 = game.current_player
          allow(game).to receive(:print_board)
          allow(player1).to receive(:print)
          allow(player1).to receive(:gets).and_return("10", "5")
          board = [1,2,3,4,6,7,8,9]
          allow(game).to receive(:free_positions).and_return(board, [5])
        end

        it "returns puts statement once" do
          player1 = game.current_player
          message = "Position 10 is not available. Try again."
          expect(player1).to receive(:puts).with(message).once
          player1.select_position!
        end
      end

      context "word as input" do
        before do
          player1 = game.current_player
          allow(game).to receive(:print_board)
          allow(player1).to receive(:print)
          allow(player1).to receive(:gets).and_return("word", "5")
          board = [1,2,3,4,6,7,8,9]
          allow(game).to receive(:free_positions).and_return(board, [5])
        end

        it "returns puts statement once" do
          player1 = game.current_player
          message = "Position 0 is not available. Try again."
          expect(player1).to receive(:puts).with(message).once
          player1.select_position!
        end
      end
    end



  end

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

