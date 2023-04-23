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

  describe "#player_has_won?" do

    context "Player 1 win" do

      context "first top horizontal X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, "X", "X", "X", "0", nil, nil, nil, nil, nil]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "middle horizontal X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, nil, nil, nil, "X", "X", "X", "0", nil, nil]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "bottom horizontal X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, nil, nil, "O", "O", nil, nil, "X", "X", "X"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "left vertical X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, "X", nil, nil, "X", nil, nil, "X", "O", "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "middle vertical X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, nil, "X", nil, nil, "X", nil, "O", "X", "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "right vertical X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, nil, nil, "X", nil, nil, "X", "O", "O", "X"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "up left to right bottom diagonal X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, "X", nil, "O", nil, "X", "O", "O", nil, "X"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end

      context "up right to left bottom diagonal X win" do
        it "returns true" do
          player1 = game.current_player
          board = [nil, "O", nil, "X", nil, "X", "O", "X", nil, "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player1)).to eq true
        end
      end
    end

    context "Player 2 win" do

      before do
        game.instance_variable_set(:@current_player_id, 1)
      end

      context "first top horizontal O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, "O", "O", "O", "0", nil, nil, nil, nil, nil]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "middle horizontal O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, nil, nil, nil, "O", "O", "O", "0", nil, nil]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "bottom horizontal O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, nil, nil, "X", "X", nil, nil, "O", "O", "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "left vertical O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, "O", nil, nil, "O", nil, nil, "O", "X", "X"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "middle vertical O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, nil, "O", nil, nil, "O", nil, "X", "O", "X"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "right vertical O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, nil, nil, "O", nil, nil, "O", "X", "X", "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "up left to right bottom diagonal O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, "O", nil, "X", nil, "O", "X", "X", nil, "O"]
          game.instance_variable_set(:@board, board)

          expect(game.player_has_won?(player2)).to eq true
        end
      end

      context "up right to left bottom diagonal O win" do
        it "returns true" do
          player2 = game.current_player
          board = [nil, "X", nil, "O", nil, "O", "X", "O", nil, "X"]
          game.instance_variable_set(:@board, board)
  
          expect(game.player_has_won?(player2)).to eq true
        end
      end
    end
  end

  context "#switch_players!" do
    context "switching from player 1 to player 2" do
      it "changes current_id_player from 0 to 1" do
        expect { game.switch_players! }.to change { 
          game.instance_variable_get(:@current_player_id)}.from(0).to(1)
      end
    end

    context "switching from player 1 to player 2" do
      it "changes current_id_player from 0 to 1" do
        game.instance_variable_set(:@current_player_id, 1)

        expect { game.switch_players! }.to change { 
          game.instance_variable_get(:@current_player_id)}.from(1).to(0)
      end
    end
  end

  context "#board_full?" do
    context "when full" do
      it "returns true" do
        full_board = [nil, "X", "O", "X", "O", "O", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, full_board)
        expect(game).to be_board_full
      end
    end
    
    context "when not full" do
      it "returns false" do
        board = [nil, "X", "O", "X", "O", "O", nil, nil, "X", "O"]
        game.instance_variable_set(:@board, board)
        expect(game).not_to be_board_full
      end
    end
  end
end