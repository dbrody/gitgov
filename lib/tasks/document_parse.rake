

task :document_parse => :environment do
	
	docfile = "manual-parsed-file.txt"
	filename = Rails.root.join('lib', 'tasks', docfile)
	file = File.open(filename, "r")
	data = file.read
	file.close
	
	rows = data.split("\n\n")

	for row in rows

		section = row.split(" ")[0..1]

		print section
		print "\n"
	end
end



