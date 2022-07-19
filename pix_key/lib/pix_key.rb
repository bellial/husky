# frozen_string_literal: true

class PixKey
    module Type
        EVP = 'evp'
        CPF = 'cpf'
        CNPJ = 'cnpj'
        PHONE = 'phone'
        EMAIL = 'email'

        Detect = ->(str) do
            return CPF if key.match?(/^[0-9]{11}$/)
            return CNPJ if key.match?(/^[0-9]{14}$/)
            return PHONE if key.match?(/^\+[1-9][0-9]\d{1,14}$/)
            return EMAIL if key.match?(/^[a-z0-9.!#$&'*+\/=?^_`{|}~-]+@a-z0-9?(?:\.a-z0-9?)*$/)
            return EVP if key.match?(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/)

            ''
        end

    attr_reader :key, :type, :valid


    def initialize(arg)
        @key = arg.is_a?(String) ? arg.strip.freeze : ''
        @type = Type::Detect[@key]
        @valid = !@type.empty?
    end 

    alias to_s key
    alias value key

    alias valid? valid
    def invalid? = !valid

    def evp? = type == Type::EVP
    def cpf? = type == Type::CPF
    def cnpj? = type == Type::CNPJ
    def phone? = type == Type::PHONE
    def email? = type == Type::EMAIL

    def == (other)
        other.class == self.class && other.key == key
    end

end
