RSpec.describe "MightyQuest Folders Spec v1.0" do
  describe "file and folder structure" do
    before do
      @parent_folder = File.expand_path("#{File.dirname(__FILE__)}/..")
    end

    it "'s root folder is 'MightyQuest'" do
      expect(@parent_folder.split(File::SEPARATOR).last).to eq('MightyQuest')
    end

    it "has lib and spec folder" do
      %w(lib spec).each do |folder|
        expect(File.directory?("#{@parent_folder}/#{folder}")).to be_truthy
      end
    end

    it "has all the files" do
      %w(main.rb lib/creature.rb spec/folders_spec.rb spec/creature_spec.rb).each do |file|
        expect(File.file?("#{@parent_folder}/#{file}")).to be_truthy, "#{@parent_folder}/#{file} does not exist"
      end
    end
  end
end
