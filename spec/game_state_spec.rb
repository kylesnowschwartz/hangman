require_relative '../lib/game_state.rb'

RSpec.describe GameState do
	let(:word) { "bottle" }
	let(:lives) { 8 }
	let(:game) { GameState.new(lives, word) }

	describe "#initialize" do

		context "with a correct arguments" do
			it "sets #lives_remaining to the correct number of lives" do
				expect(game.lives_remaining).to eq 8
			end

			it "sets #guessed_letters to an empty array" do
				expect(game.guessed_letters).to eq([])
			end

			it "sets #board to an array of underscores" do
				expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
			end
		end

		context "with an incorrect arguments" do
			it "raises an error when given 0 lives" do
				expect { GameState.new(0, "bottle") }.to raise_error("The number of lives must be greater than zero")
			end

			it "raises an error when given a word less than 3 letters long" do
				expect { GameState.new(3, "at") }.to raise_error("The word must have 3 or more letters")
			end
		end
	end

	describe "#finished?" do
		context "with lives remaining" do
			it "returns false" do
				expect(game.finished?).to be false
			end
		end

		context "with no lives remaining" do
			let(:lives) { 1 }
			before do
				game.submit_guess("z")
			end
			
			it "returns true" do
				expect(game.finished?).to be true
			end
		end
	end

	describe "#board" do
		context "with correct letter" do
			it "replaces a blank tile" do
				game.submit_guess("B")
				expect(game.board).to eq(["B", "_", "_", "_", "_", "_"])
			end
		end

		context "with incorrect letter" do
			it "does not replace a blank tile" do
				game.submit_guess("Z")
				expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
			end
		end

		describe "#submit_guess" do
			context "with a correct guess" do
				it "returns true" do
					expect(game.submit_guess("B")).to be true
				end
			end

			context "with a incorrect guess" do
				it "returns false" do
					expect(game.submit_guess("Q")).to be false
				end
			end
		end
	end
end