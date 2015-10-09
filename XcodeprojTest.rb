require 'Xcodeproj'

module Qwerty

	project_name = "TestProject"
	project_file_name = project_name + ".xcodeproj"
	project_ref = Xcodeproj::Project.new(project_file_name)
	project_ref.initialize_from_scratch

	group_name = "QwertyGroup"
	group_ref = project_ref.new_group(group_name)
	file_name = "Test.h"
	file = group_ref.new_file(file_name)

	file_name = "Test.m"
	file1 = group_ref.new_file(file_name)

	files = [file, file1]

	net_group_name = "NiceGroup"
	net_group_ref = project_ref.new_group(net_group_name)
	file_name = 'Qwe.h'
	file3 = net_group_ref.new_file(file_name)
	files.push(file3)
	file_name = 'Qwe.m'
	file4 = net_group_ref.new_file(file_name)
	files.push(file4)


	main_target = project_ref.new_target(:application,"Test target", :ios, "8.0")
	main_target.add_file_references(files)
 
# Save the project file
	project_ref.save()
	
	# rewrite Podfile
	podfile = File.open("Podfile", "w")
	podfile.puts "pod 'ReactiveLocalizationManager', '~> 1.2'"
	podfile.close
	#install pods
	system("pod install")
end