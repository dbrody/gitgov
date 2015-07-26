

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
		:elements => []
	}

	# Stores docs
	state = {}

	last_level = 0
	for row in rows

		parts = row.split(" ")
		label = parts[0]
		section = parts[1]
		rest = 2
		if section[0] == "<"
			while true
				if section[-1] == ">"
					break
				end
				section += " " + parts[rest]
				rest += 1
			end
			section = section[1..-2]
		end

		if label == "[TITLE]"
			document_elements[:title] = parts[1..-1].join(" ")
			next
		elsif label == "[DATE]"
			document_elements[:date] = parts[1..-1].join(" ")
			next
		elsif label[0] == "[" and label[-1] == "]"
			state[0][:notes] ||= []
			state[0][:notes].append(parts[1..-1].join(" "))
			next
		end

		level = label.length

		print "Creating level: ", level, "\n"
		state[level] = {
			:section => section,
			:title => parts[rest..-1].join(" "),
			:elements => [],
			:notes => []
		}

		# Clear out all sub levels
		sub_level = level + 1
		while state.has_key?(sub_level)
			state[sub_level] = nil
			sub_level += 1
		end

		# Make sure all parent nodes exist
		parent_level = 0
		while parent_level < level
			if not state.has_key?(parent_level) or state[parent_level] == nil
				state[parent_level] = {
					:section => "",
					:title => "",
					:elements => []
				}
				print "Making level ", parent_level, "\n"
				if parent_level != 0
					state[parent_level - 1][:elements].append(state[parent_level])
				end
			end
			parent_level += 1
		end 

		## Add current level to parent item
		state[level - 1][:elements].append(state[level])
	end

	document_elements[:elements] = [state[0]]

	print JSON.pretty_generate(document_elements)

	parse_document_root(document_elements)
end

def parse_document_root(root)
	d = Document.where({name: root[:title]}).first_or_create({
		:date => root[:date]
	})

	print root[:title]
	print "\n"
	print root[:date]
	print "\n"
	root_element = DocumentElement.create({
		body: root[:title],
		document: d,
		type: "DocumentElement",
		position: 0,
		numeral: "",	
	})

	print root_element.attributes, "\n"
	print root_element.id, "\n"
	print "\n"

	d.root_element = root_element.id
	d.save

	parse_document_level(d, root, root_element)
end

def parse_document_level(document, parent, parent_object=nil, level = 0)
	i = 0
	for element in parent[:elements]

		elem = DocumentElement.create({
			body: element[:title],
			document: document,
			type: "DocumentElement",
			position: i,
			numeral: element[:section],	
		})

		elem.move_to_child_of(parent_object)
		
		print "-"*(level*2)
		concat = element[:title][0..30].gsub(/\s\w+\s*$/, '...')
		print element[:section], "(", elem.id, "->", (elem.parent) ? elem.parent.id : 0, ")", concat, "\n"
		# print JSON.pretty_generate(element)
		parse_document_level(document, element, elem, level+1)
		i += 1
	end
end







