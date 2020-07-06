# frozen_string_literal: true

system 'rm template.rb'
system 'touch template.rb'

system 'cat files/base.rb >> template.rb' # always needs to be first
system 'cat files/bootstrap.rb >> template.rb'
system 'cat files/bulma.rb >> template.rb'
system 'cat files/foundation.rb >> template.rb'
system 'cat files/tailwind.rb >> template.rb'
system 'cat files/ask.rb >> template.rb' # always needs to be last

text = File.read('template.rb')
File.open('template.rb', 'w') { |file| file.puts text }

p 'template file finished building'
