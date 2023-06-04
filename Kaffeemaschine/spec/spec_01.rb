
# kaffee_maschine_spec 1

RSpec.describe "Autoated Coffee Machine v0.1" do
    # Source: http://stackoverflow.com/questions/16507067/testing-stdout-output-in-rspec
    def capture_stdout &block
      old = $stdout
      $stdout = fake = StringIO.new
      yield
      fake.string
    ensure
      $stdout = old
    end
  
    describe "file and folder structure" do
      it "is a nice ruby project structure" do
        parent_folder = File.expand_path(File.dirname(__FILE__))
        # Folders
        expect(parent_folder.split(File::SEPARATOR)[-2]).to eq('Kaffeemaschine')
        expect(File.directory?('lib')).to be_truthy
  
        # Files
        expect(File.file?('main.rb')).to be_truthy
        expect(File.file?('lib/kaffee_maschine.rb')).to be_truthy
      end
    end
  
    describe "Kaffeemaschine" do
      before load_machine: true do
        require_relative '../lib/kaffee_maschine.rb'
        @kaffee_maschine = KaffeeMaschine.new
      end
  
      it "loads coffee machine", load_machine: true do
        expect(defined?(KaffeeMaschine)).to be_truthy
      end
  
      it "defines required methods", load_machine: true do
        expect(@kaffee_maschine.respond_to?(:einschalten)).to be_truthy, "method 'einschalten' is not defined"
        expect(@kaffee_maschine.respond_to?(:koche_kaffee)).to be_truthy, "method 'koche_kaffee' is not defined"
      end
  
      it "prints a 'ready'-message when turned on (pun intended)", load_machine: true do
        out = capture_stdout do
          @kaffee_maschine.einschalten # do your actual method call
        end
  
        expect(out).to eq("Kaffeemaschine ist eingeschaltet!\n")
      end
  
      it "prints 3 cups of tasty coffee", load_machine: true do
        out = capture_stdout do
          @kaffee_maschine.einschalten
          @kaffee_maschine.koche_kaffee 3, drink: :kaffee
        end
  
        expect(out.strip).to eq("Kaffeemaschine ist eingeschaltet!\n☕ ☕ ☕").or eq("Kaffeemaschine ist eingeschaltet!\n|_|P |_|P |_|P")
      end
    end
  
    describe "Main Program" do
      it "runs the main program and pours delicous coffee" do
        out = capture_stdout do
          load "main.rb"
        end
  
        expect(out.strip).to eq("Kaffeemaschine ist eingeschaltet!\n☕ ☕ ☕").or eq("Kaffeemaschine ist eingeschaltet!\n|_|P |_|P |_|P")
      end
    end
  
    describe "Uncontrolled 'Wasserfüllstand'" do
      before load_machine: true do
        require_relative '../lib/kaffee_maschine.rb'
      end
  
      it "checks initialization of attribute 'wasserfuellstand'", load_machine: true do
        @kaffee_maschine = KaffeeMaschine.new
        wasserfuellstand = @kaffee_maschine.instance_variable_get("@wasserfuellstand")
        expect(wasserfuellstand).to be(3)
      end
  
      it "checks value of constant 'CupSize'", load_machine: true do
        expect(defined? KaffeeMaschine::CupSize).to be_truthy
        expect(KaffeeMaschine::CupSize).not_to eq("DD")
        expect(KaffeeMaschine::CupSize).to eq(1)
      end
  
      it "checks if consumed water is corecctly substracted from the 'wasserfuellstand'" do
        @kaffee_maschine = KaffeeMaschine.new
        out = capture_stdout do
          @kaffee_maschine.koche_kaffee 3
        end
  
        wasserfuellstand = @kaffee_maschine.instance_variable_get("@wasserfuellstand")
        expect(wasserfuellstand).to be(0)
      end
    end
  end
  