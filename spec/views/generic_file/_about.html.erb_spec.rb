require 'spec_helper'

describe "generic_files/_about_stats.html.erb" do
  let(:groups) { [] }
  let(:ability) { instance_double("Ability") }
  let(:about_stats_text) { ContentBlock.new(name: ContentBlock::ABOUTSTATS, value: about_stats_value) }

  subject { rendered }

  before do
    assign(:about_stats_text, about_stats_text)
    allow(controller).to receive(:current_ability).and_return(ability)
    allow(ability).to receive(:can?).with(:update, ContentBlock).and_return(can_update_content_block)
    render
  end

  context "when there is an announcement" do
    let(:about_stats_value) { "I have info about the stats page!" }

    context "when the user can update content" do
      let(:can_update_content_block) { true }

      it { is_expected.to have_content about_stats_value }
      it { is_expected.to have_button("Edit") }
    end

    context "when the user can't update content" do
      let(:can_update_content_block) { false }

      it { is_expected.to have_content about_stats_value }
      it { is_expected.not_to have_button("Edit") }
    end
  end

  context "when there is no announcement" do
    let(:about_stats_value) { "" }

    context "when the user can update content" do
      let(:can_update_content_block) { true }

      it { is_expected.to have_selector "#about_stats_text" }
      it { is_expected.to have_button("Edit") }
    end

    context "when the user can't update content" do
      let(:can_update_content_block) { false }

      it { is_expected.not_to have_selector "#about_stats_text" }
    end
  end
end
