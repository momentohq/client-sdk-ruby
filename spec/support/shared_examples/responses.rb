shared_examples 'response has status methods' do |true_statuses: []|
  statuses = [
    :success,
    :error,
    :already_exists,
    :invalid_argument,
    :not_found,
    :permission_denied
  ]

  false_statuses = statuses - true_statuses

  false_statuses.each do |status|
    describe "#{status}?" do
      method = :"#{status}?"
      it 'is false' do
        expect(response.public_send(method)).to be false
      end
    end

    describe "as_#{status}" do
      method = :"as_#{status}"
      it 'is nil' do
        expect(response.public_send(method)).to be_nil
      end
    end
  end

  true_statuses.each do |status|
    describe "#{status}?" do
      method = :"#{status}?"
      it 'is true' do
        expect(response.public_send(method)).to be true
      end

      it 'is itself' do
        method = :"as_#{status}"
        expect(response.public_send(method)).to be response
      end
    end
  end
end
