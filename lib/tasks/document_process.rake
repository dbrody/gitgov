

task :document_process => :environment do
	
	newdocfile = Rails.root.join('lib', 'tasks', 'parsed-file.txt')

	docfile = "full-text-of-the-iran-nuclear-deal.txt"
	filename = Rails.root.join('lib', 'tasks', docfile)
	file = File.open(filename, "r")
	data = file.read
	file.close
	
	data = data.gsub("\n\n", '<****>')
	data = data.gsub("\n", "")
	data = data.gsub("<****>", "\n\n")

	p data

	File.open(newdocfile, 'w') { |file|
		file.write(data)
	}
end