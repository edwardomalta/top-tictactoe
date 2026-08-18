require_relative "../lib/game"
require_relative "../lib/display"

describe Game do
  describe "#start" do
    subject(:game_start) { described_class.new }
    let(:display_double) { double("Display", show_board: nil) }

    context "receives correct movement" do
      before do
        allow(game_start).to receive(:make_move)
        allow(game_start).to receive(:status)
        game_start.instance_variable_set(:@display, display_double)
      end
      it "calls #get_player_move by 3" do
        allow(game_start).to receive(:game_over?).and_return(false, false, true)
        expect(game_start).to receive(:get_player_move).exactly(3).times
        game_start.start
      end

      xit "increases @counter by one" do
      end

      xit "calls @display.show_board" do
      end

      context "when there is a winner" do
        xit "ends with congrats to winner" do
        end
      end

      context "when there is no way to win" do
        xit "ends with tables message" do
        end
      end
    end
  end
end
