require 'rails_helper'

RSpec.describe BoardPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:board) { FactoryBot.create(:board, user_id: user.id) }
  let(:policy) { described_class.new(user, board) }


  describe 'show?' do
    context 'when the user has the "show_board" permission' do
      before { user.role.access_controls.create(permission: create(:permission, name: 'show_board')) }
      
      it 'allows access' do
        expect(policy.show?).to be_truthy
      end
    end

    context 'when the user does not have the "show_board" permission' do
      it 'denies access' do
        expect(policy.show?).to be_falsey
      end
    end
  end

  describe 'create?' do
    context 'when the user has the "create_board" permission' do
      before { user.role.access_controls.create(permission: create(:permission, name: 'create_board')) }
      
      it 'allows access' do
        expect(policy.create?).to be_truthy
      end
    end

    context 'when the user does not have the "create_board" permission' do
      it 'denies access' do
        expect(policy.create?).to be_falsey
      end
    end
  end

  describe 'update?' do
    context 'when the user has the "update_board" permission' do
      before { user.role.access_controls.create(permission: create(:permission, name: 'update_board')) }
      
      it 'allows access' do
        expect(policy.update?).to be_truthy
      end
    end

    context 'when the user does not have the "update_board" permission' do
      it 'denies access' do
        expect(policy.update?).to be_falsey
      end
    end
  end

  describe 'destroy?' do
    context 'when the user has the "destroy_board" permission' do
      before { user.role.access_controls.create(permission: create(:permission, name: 'destroy_board')) }
      
      it 'allows access' do
        expect(policy.destroy?).to be_truthy
      end
    end

    context 'when the user does not have the "destroy_board" permission' do
      it 'denies access' do
        expect(policy.destroy?).to be_falsey
      end
    end
  end
end
