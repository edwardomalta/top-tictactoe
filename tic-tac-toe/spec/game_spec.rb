require_relative "../lib/game"
require_relative "../lib/display"

describe Game do
  describe "#start" do
    subject(:game_start) { described_class.new }
    let(:display_double) { double("Display", show_board: nil) }

    context "receives correct movement" do
      before do
        allow(game_start).to receive(:make_move)
        allow(game_start).to receive(:player_move)
        game_start.instance_variable_set(:@display, display_double)
      end
      it "calls #player_move by 3" do
        allow(game_start).to receive(:game_over?).and_return(false, false, true)
        expect(game_start).to receive(:player_move).exactly(3).times
        game_start.start
      end

      context "when there is a winner" do
        it "ends with congrats to winner" do
          allow(game_start).to receive(:game_over?).and_return(false, false, true)
          expect(game_start).to receive(:announce_winner).once
          game_start.start
        end
      end

      context "when there is no way to win" do
        it "ends with tables message" do
          allow(game_start).to receive(:game_over?).and_return(true)
          expect(game_start).to receive(:announce_winner).once
          game_start.start
        end
      end
    end
  end

  describe "#position_to_index" do
    subject(:game_position) { described_class.new }

    it "returns 0 for a1" do
      result = game_position.position_to_index("a1")
      expect(result).to eq(0)
    end
    it "returns 8 for c3" do
      result = game_position.position_to_index("c3")
      expect(result).to eq(8)
    end
  end

  describe "#game_over?" do
    subject(:game_over) { described_class.new }
    let(:display) { double("Display", show_board: nil) }
    context "when correct conditions are met" do
      before do
        game_over.instance_variable_set(:@display, display)
      end

      it "is true when there is a line in the board" do
        line_board = [
          "X", "X", "X",
          "", "", "",
          "", "", ""
        ]
        game_over.instance_variable_set(:@board, line_board)
        game_over.update_winner
        expect(game_over.game_over?).to be(true)
        expect(game_over.winner).to eq("X")
      end

      it "is true when there is diagonal too" do
      end

      it "is true when there is a vertical too" do
      end

      it "is false when there is not enought marks in the line" do
      end

      it "is false if there are mixed marks" do
      end
    end
  end
end
