# potato-os

An OS made by h3lped that is totally hot garbage

~~**This Project is on hold since im on a windows machine**~~ **I'm back ;)**

## Features

- Just says Hello World!

## Setup (Using Docker for Windows)

1. First get the Docker CLI if you haven't done so already because it is required for this

2. Open your Command prompt and cd into the directory with all the files

3. Run `docker build docker -t (name the container)` (it may take a while because its a new container that is building but just give it some time!)

4. Once it's built run `docker run --rm -it -v "%cd%":/root/env (name of container)`

And Thats it you have setup an environment to make an .img file! You can now follow the instructions below!

## Build the Source

1. Open the terminal/command prompt

2. Run `git clone https://github.com/Potatopy/potato-os.git`

3. Next Run `cd potato-os`

4. Install all the dependancies by running `chmod +x cli/install.sh` + `./cli/install.sh`

5. Run `make` in the terminal that has the source files

. And then run `chmod +x cli/boot.sh` + `./cli/boot.sh`

## NOTE

Reminder that if you see some errors in any of the codes. It ok! I have tested the compiled part and it work seamlessly!

## License + Credits

[MIT](https://opensource.org/license/mit/)

[The guy who made this](https://github.com/nanobyte-dev/nanobyte_os)
