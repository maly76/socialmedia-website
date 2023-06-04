# kaffee_maschine_spec 2

RSpec.describe "Autoated Coffee Machine v0.2" do
    # Source: http://stackoverflow.com/questions/16507067/testing-stdout-output-in-rspec
    def capture_stdout &block
      old = $stdout
      $stdout = fake = StringIO.new
      yield
      fake.string
    ensure
      $stdout = old
    end
  
    describe "Controlled 'Wasserfüllstand'" do
      before lade_maschine: true do
        require_relative '../lib/kaffee_maschine.rb'
        @kaffee_maschine = KaffeeMaschine.new
      end
  
      it 'will check for custom exceptions', lade_maschine: true do
        expect(defined? NotEnoughWaterLeftError).to be_truthy
        expect(defined? NotOnlineError).to be_truthy
      end
  
      it 'will not allow to cook coffee if is off', lade_maschine: true do
        expect {@kaffee_maschine.koche_kaffee 4, drink: :tee}.to raise_error(NotOnlineError)
      end
  
      it 'will not allow to cook coffee if has not enough water in water tank', lade_maschine: true  do
        out = capture_stdout do
          @kaffee_maschine.einschalten
        end
        expect {@kaffee_maschine.koche_kaffee 4, drink: :tee}.to raise_error(NotEnoughWaterLeftError)
      end
  
      it 'will pour delicious tea', lade_maschine: true do
        @kaffee_maschine.einschalten
        out = capture_stdout do
          @kaffee_maschine.koche_kaffee 2, drink: :tee
        end
  
        expect(out.strip).to eq('🍵 🍵').or eq('T T')
      end
  
      it 'will pour delicious himbeer', lade_maschine: true do
        @kaffee_maschine.einschalten
        out = capture_stdout do
          @kaffee_maschine.koche_kaffee 2, drink: :himbeer
        end
  
        expect(out.strip).to eq('🍺 🍺').or eq('o0 o0')
      end
  
      it 'will pour delicious coffee again', lade_maschine: true do
        @kaffee_maschine.einschalten
        out = capture_stdout do
          @kaffee_maschine.koche_kaffee 2, drink: :kaffee
        end
  
        expect(out.strip).to eq('☕ ☕').or eq('|_|P |_|P')
      end
    end
  end
  