# frozen_string_literal: true

class PixKey
    attr_accessor :pix_key, :key

    CPF = /^[0-9]{11}$/
    CNPJ = /^[0-9]{14}$/
    PHONE = /^\+[1-9][0-9]\d{1,14}$/
    EMAIL = /^[a-z0-9.!#$&'*+\/=?^_`{|}~-]+@a-z0-9?(?:\.a-z0-9?)*$/
    EVP = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

    def initialize(pix_key)
        @pix_key = pix_key
        #@key = 'email@husky.io'
    end

    def to_s
        @key = @pix_key.to_s
    end

    def value
        cpf_value = @key =~ PixKey::CPF
        cnpj_value = @key =~ PixKey::CNPJ
        phone_value = @key =~ PixKey::PHONE
        email_value = @key =~ PixKey::EMAIL
        evp_value = @key =~ PixKey::EVP

        @pix_key = PixKey.new(key).to_s
        @cpf = PixKey.new(cpf_value).to_s
        @cnpj = PixKey.new(cnpj_value).to_s
        @phone = PixKey.new(phone_value).to_s
        @email = PixKey.new(email_value).to_s
        @evp = PixKey.new(evp_value).to_s

    end

    def valid?
        valid = [{key: '12312312334'}, 
            {key: '12345678901234'}, 
            {key: '+5510998765432'}, 
            {key: 'email@husky.io'}, 
            {key: '123e4567-e89b-12d3-a456-426655440000'}]

        invalid = [{key: '1231231123122334'}, 
            {key: 'invalid'}, 
            {key: '551099876543299'}, 
            {key: 'emailhusky.io'}, 
            {key: '11123e45670sdsd00a-e21289b-12d3-a456-426655440000'}]

        valid.each do |key|
            return true if valid
        end
        

    end
    def key
        @pix_key.eql?(@key)

    end

    def type
        type = {'cpf' => '86110735094',
            'cnpj' => '75928551000119',
            'phone' => '+55998822334',
            'email' => 'email@husky.io',
            'evp' => '123e4567-e89b-12d3-a456-426655440000'}
        type = 'cpf' ##wrong stuff
    end

    def cpf?
        key = '86110735094'
        invalid_cpf = ['86110735099',
            '861.107.350-94',
            '+5582998899889',
            'fernando@husky',
            '123e4567-e89b-12d3-a456-426655440000']
        invalid_cpf.include? key

    end

    def cnpj?
        key = '75928551000119'
        valid_cnpj = '75928551000119'
        invalid_cnpj = ['75.928.551/0001-19',
            '75928551000118',
            '861.107.350-94',
            '+5582998899889',
            'fernando@husky',
            '123e4567-e89b-12d3-a456-426655440000']
        invalid_cnpj.include? key

    end
    def phone?
        key = '+55861107350'

        invalid_phone = ['55861107350',
            'fernando@husky',
            '123e4567-e89b-12d3-a456-426655440000']
        invalid_phone.include? key



    end
    def email?
        @key

        invalid_email = ['emailhusky.io',
            '75.928.551/0001-19',
            '861.107.350-94',
            '+5582998899889',
            '123e4567-e89b-12d3-a456-426655440000']
        invalid_email.include? @key
    end
    def evp?
        key = '123e4567-e89b-12d3-a456-426655440000'

        invalid_evp = ['75.928.551/0001-19',
            '861.107.350-94',
            '+5582998899889',
            'fernando@husky']
        if invalid_evp.include? key
            return false
    end

end