# README

This is a toy project to illustrate how to use `Dockerfile` and `docker-compose` in a project with typical data science constraints. What are these?

- I need to deploy several versions of the same models, with different parameters but same data, and different persistence.
- All models (containers) will read from the same `data` directory.
- The Software stack is the same, but each `run` is different depending on the parameters they're configured to run with.
- The output from each model needs to be persisted, sometimes. In this case, this is _inference_ time, so we don't need it. Our `output` directory will be inside the docker and will be destroyed once the docker ends.

So, this is how our project structure looks:

    docker-test
      ├── Dockerfile
      ├── README.md
      ├── data                -> ~/docker-test/data
      │   └── file.csv
      ├── docker-compose.yml
      ├── models              -> ~/docker-test/models
      │   └── model1.json
      ├── module1
      │   └── entry1.py
      ├── module2
      │   └── entry2.py
      ├── output
      ├── pipeline.sh
      └── requirements.txt

The image is built by calling (please, clone this repo, first!):

`$ docker-compose build`

and then executed by calling:

`$ docker-compose up`

The contents of the `Dockerfile`, establishes that everything will run in a directory called `/tester` inside the docker. Within this directory, some of the sub-directories (bold) are _Volumes_ pointing to host filesystem folders, and some others will be created inside the image (we don't care if we loose their contents).

The contents of the `docker-compose.yml`:

    version: '3'
    services:
      tester:
        build: .
        image: tester:0.1.0
        volumes:
            - ./data:/tester/data
            - ./models:/tester/models

As seen, all contents from the root directory are copied inside the container image, BUT the directories `data` and `models` will be volumes mounted over the host filesystem, referencing therefore, the actual files in the host, not in the container.

Now, you can change the contents of `data` or `models` from your computer (host) and everytime you fire up the container, those changes will be reflected in your execution. At the same time, changes in code, in you machine will never affect your docker, unless you rebuild the image.
