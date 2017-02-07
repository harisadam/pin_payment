module PinPayment
  class Error < StandardError

    def self.create type, description, messages = nil
      klass = case type
        when 'token_already_used'; TokenAlreadyUsed
        when 'invalid_resource';   InvalidResource
        when 'resource_not_found'; ResourceNotFound
        when 'card_declined'; CardDeclined
        when 'insufficient_funds'; InsufficientFunds
        when 'processing_error'; ProcessingError
        when 'suspected_fraud'; SuspectedFraud
        when 'expired_card'; ExpiredCard

        else self
      end
      if messages.is_a?(Array)
        description = description + ' ' + messages.map{|x| "(#{x['message']})" }.join(' & ')
      elsif messages.is_a?(Hash)
        description = description + ' ' + messages.values.flatten.map{|x| "(#{x})" }.join(' & ')
      end
      klass.new(description)
    end

    class InvalidResponse  < Error; end
    class InvalidResource  < Error; end
    class ResourceNotFound < Error; end
    class TokenAlreadyUsed < Error; end
    class CardDeclined < Error; end
    class InsufficientFunds < Error; end
    class ProcessingError < Error; end
    class SuspectedFraud < Error; end
    class ExpiredCard < Error; end

  end
end
