# potato-os

An OS made by h3lped that is totally hot garbage

**This Project is on hold since im on a windows machine**

## Features

- Just says Hello World!

## Setup (Using Docker for Windows)

1. First get the Docker CLI if you haven't done so already because it is required for this

2. Open your Command prompt and cd into the directory with all the files

3. Run `docker build docker -t (name the container)` (it may take a while because its a new container that is building but just give it some time!)

4. Once it's built run `docker run --rm -it -v "%cd%":/root/env (name of container)`

And Thats it you have setup an environment to make an .img file

## Build the Source

1. Open the terminal

2. And simply run `make`

3. Open the `build` folder and you will see the .img file

## License

[MIT](https://opensource.org/license/mit/)
