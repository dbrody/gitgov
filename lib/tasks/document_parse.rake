

task :document_parse => :environment do
	
	docfile = "manual-parsed-file.txt"
	filename = Rails.root.join('lib', 'tasks', docfile)
	file = File.open(filename, "r")
	data = file.read
	file.close
	
	rows = data.split("\n\n")

	document_elements = {
		:title => nil,
		:date => nil,
		:preface => [],
		:elements => {
		}
	}

	state = {
		:root => nil 
	}

	for row in rows

		parts = row.split(" ")
		label = parts[0]
		section = parts[1]
		rest = 2
		if section[0] == "<"
			while true
				section += " " + parts[rest]
				rest += 1
				if section[-1] == ">"
					break
				end
			end
			section = section[1..-2]
		end

		if label == "[TITLE]"
			document_elements[:title] = parts[1..-1].join(" ")
			next
		elsif label == "[DATE]"
			document_elements[:date] = parts[1..-1].join(" ")
			next
		elsif label == "[PREFACE]"
			document_elements[:preface].append(parts[1..-1].join(" "))
			next
		elsif label[0] == "[" and label[-1] == "]"
			document_elements[:elements][state[:root]][:notes] ||= []
			document_elements[:elements][state[:root]][:notes].append(parts[1..-1].join(" "))
			next
		end

		if label == "*"
			state[:root] = section
			state[:sub] = nil
			document_elements[:elements][section] = {
				:title => parts[rest..-1].join(" "),
				:elements => { }
			}
		elsif label == "**"
			state[:sub] = section
			document_elements[:elements][state[:root]][section] = {
				:title => parts[rest..-1].join(" ")
			}
		elsif label == "***"
			state[:subsub] = section
			document_elements[:elements][state[:root]][state[:sub]][section] = {
				:title => parts[rest..-1].join(" ")
			}
		elsif label == "****"
			state[:subsubsub] = section
			document_elements[:elements][state[:root]][state[:sub]][state[:subsub]][section] = {
				:title => parts[rest..-1].join(" ")
			}
		else 
			print "ERROR:"
			print label + ", " + section
			print "\n"
		end
	end

	# print JSON.pretty_generate(document_elements)
end



