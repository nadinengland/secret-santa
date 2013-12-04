require_relative 'lib/secret_santa_generator.rb'
require 'gmail'

# Who's involved?
emails = {
  "PersonA" => "user@domain.com",
  "PersonB" => "user@domain.com",
  "PersonC" => "user@domain.com",
  "PersonD" => "user@domain.com",
  "PersonE" => "user@domain.com",
  "PersonF" => "user@domain.com",
  "PersonG" => "user@domain.com",
  "PersonH" => "user@domain.com"
}

# Should any people not pick each other?
contraints = [ [ "PersonC", "SarahD" ], [ "PersonA", "PersonF"] ]

# Get picking!
generator = SecretSantaGenerator.new people, constraints

if not generator.valid?
  puts "Unable to generate combinations!"
else

  puts "Which year would you like to draw for?: "
  year = gets.to_i

  puts "Which gmail address shall we send from?: "
  username = gets

  puts "And finally, what is the password for this account?: "
  password = gets

  recipients = generator.pick(year)
  matches = Hash[emails.keys.zip(recipients)]

  Gmail.new(username, password) do |gmail|
    matches.each do |santa, recipient|
      gmail.deliver do
        to      emails[santa]
        subject "Secret Santa!"
        body    "#{santa}, you are buying for #{recipient}"
      end
    end

    1000.times { puts "\"" }
    puts "Done! Check your email."
  end
end