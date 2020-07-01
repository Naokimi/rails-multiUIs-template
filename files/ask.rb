# frozen_string_literal: true

def pick_option
  option = ask 'pick a number'

  case option
  when '1' then bootstrap_framework
  when '2' then bulma_framework
  when '3' then foundation_framework
  when '4' then tailwind_framework
  else
    say 'Error - please pick a number from the list'
    pick_option
  end
end

say '-- Welcome to Personal Projects Templates! --'
say 'a list of templates to experiment with different UI frameworks'
say
say 'please pick a template from the list:'
say '1 - Bootstrap:  The most popular HTML, CSS, and JS library in the world'
say '2 - Bulma:      A pure CSS framework based on Flexbox and built with Sass'
say '3 - Foundation: The most advanced responsive front-end framework in the world'
say '4 - Tailwind:   A utility-first CSS framework for rapidly building custom designs'
say

pick_option
