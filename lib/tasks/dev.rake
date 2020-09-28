namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD ...") do 
        %x(rails db:drop:_unsafe)
      end
      
      show_spinner("Criando BD ...") do 
        %x(rails db:create)
      end
      
      show_spinner("Migrando BD ...") do 
        %x(rails db:migrate)
      end
      %x(rails dev:add_minning_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end
  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
         {
            description: 'Bitcoin',
            acronym: 'BTC',
            url_image: 'https://www.logopik.com/wp-content/uploads/edd/2018/07/Bitcoin-Logo-PNG.png',
            minning_type: MinningType.find_by(acronym: 'PoW')
         },
         {
            description: 'Ethereum',
            acronym: 'ETH',
            url_image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/368px-Ethereum_logo_2014.svg.png',
            minning_type: MinningType.all.sample
         },
         {
            description: 'Dash',
            acronym: 'DASH',
            url_image: 'https://www.pngkit.com/png/detail/135-1353048_dash-icon-dash-coin-logo-png.png',
            minning_type: MinningType.all.sample
         },
         {
            description: 'Iota',
            acronym: 'IOT',
            url_image: 'https://faviconer.net/preloaders/871/Iota%20logo%20spinning.jpg',
            minning_type: MinningType.all.sample
         },
         {
            description: 'ZCash',
            acronym: 'ZEC',
            url_image: 'https://cryptoai.trade/wp-content/uploads/2020/03/zec-2.png',
            minning_type: MinningType.all.sample
         }
      ]
      
      coins.each do |coin|
         Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastra os tipos de mineração"
  task add_minning_types: :environment do
    show_spinner("Cadastrando tipos de mineraçao...") do
      minning_types = [
        {
          description: "Proof of Work",
          acronym: "PoW"
        },
        {
          description: "Proof of Stack",
          acronym: "PoS"
        },
        {
          description: "Proof of Capacity",
          acronym: "PoC"
        }
      ]
      minning_types.each do |type|
        MinningType.find_or_create_by!(type)
      end
    end
  end
  
  private
    def show_spinner(msg_start, msg_stop = "Concluído!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("#{msg_stop}")
    end
  
end
