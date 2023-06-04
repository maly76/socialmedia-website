require_relative "./lib/Kaffee_maschine.rb"

kaffee_maschine = KaffeeMaschine.new

kaffee_maschine.einschalten
kaffee_maschine.koche_kaffee(3, drink: :kaffee)