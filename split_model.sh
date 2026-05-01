tar -czvf - //usr/share/ollama/.ollama/models | split -b 20M - part_
