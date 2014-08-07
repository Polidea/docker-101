import yaml
import jinja2

people_file = open('people.yaml', 'r')
people_data = yaml.load(people_file)

loader = jinja2.FileSystemLoader(searchpath='.')
template_environment = jinja2.Environment(loader=loader)
template = template_environment.get_template('index_template.html')
output = template.render(people_data)
output_file = open('index.html', 'wr+')
output_file.write(output.encode('utf8'))
output_file.close()