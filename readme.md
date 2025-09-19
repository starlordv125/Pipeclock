# Pipeclock
Pipeclock is a shell script which will eventually turn into a gui application with a shell script backend.
## Usecase
Pipeclock is intended for use only with pipewire systems, it will not work with pulseaudio or others. As of now the program accepts a minimum and maximum clock value and will create a configuration file to reflect those speeds.
## Troubleshooting
This is certainly not going to be a perfect program, so here is some information that will help you if this program happens to mess up something:
### Config file
The config file that Pipeclock creates will be in `~/.config/pipewire/pipewire.conf.d/` and will be named `clock.conf`. The contents of this file will look something like this:
```
context.properties = {
    default.clock.allowed-rates = [ 44100, 48000, 88200, 96000 ]
}
```
This will let pipewire adjust its clock rate to any media that matches those clock rates. This file can be deleted with no consequences, and should not break anything.