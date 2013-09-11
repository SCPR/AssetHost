require 'spec_helper'

describe AssetHostCore::ApiUser do
  describe '::authenticate' do
    it "finds the user by auth token" do
      user = create :api_user, auth_token: "12345"

      AssetHostCore::ApiUser.authenticate("12345").should eq user
    end
  end

  describe "auth token generation" do
    let(:api_user) { build :api_user }
    subject { api_user }

    context 'before save' do
      its(:auth_token) { should be_blank }
    end

    context 'on create' do
      before { subject.save! }
      its(:auth_token) { should be_present }
    end
  end


  describe '#may?' do
    let(:api_user) { create :api_user }

    context "when the user has the permission" do
      subject { api_user }

      before :each do
        api_user.permissions.create(
          :ability    => "read",
          :resource   => "AssetHostCore::Asset"
        )
      end

      it { should be_allowed_to :read, "AssetHostCore::Asset" }
    end

    context "when the user does not have the permission" do
      it { should_not be_allowed_to :read, "AssetHostCore::Asset" }
    end
  end
end
