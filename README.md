# SWARM

SWARM is a motion-controlled mini-game. It was created by [Nikolas Klein](http://nikolasklein.de), Miguel Pawlowski, [Florian Ludwig](http://www.florian-ludwig.de) and [Christoph Labacher](http://www.christophlabacher.com) within two weeks as part of a workshop by [Prof. Dr. Franklin Hernández-Castro](http://skizata.com) in spring 2014 at [Hochschule für Gestaltung Schwäbisch Gmünd](http://hfg-gmuend.de/).


[![](/Readme/playing_1.png)](https://vimeo.com/christophlabacher/swarm)
*Video: [www.vimeo.com/christophlabacher/swarm](https://vimeo.com/christophlabacher/swarm)*

There are two versions available: Processing and HTML5/JavaScript.




## Gameplay

A swarm of fireflies is flying through a cave. The user can alter its altitude by moving his right hand up or down. He has to, since the fireflies can get caught on the cave’s walls. Sometimes one has to navigate through narrow spaces – clenching a fist with your right hand focuses the swarm and makes it easier controllable for a short time. After the a couple of seconds of being focused the fireflies are being spread apart.

![Gameplay](/Readme/gameplay_1.png)

Within the level there are six “Soundspots”. In order to activate it the user has to make a couple of fireflies pass through. Once activated, a layer of sound is starting to play. The aim is to complete the playing piece of music, by activating as many “Soundspots” as possible.

![Gameplay](/Readme/gameplay_2.png)

If the player manages to get through to the end of the level with a couple of fireflies left, he is shown his score: for every two “Soundspots” activated, there is one medal.

## Technology

SWARM was developed within two weeks as part of a four week workshop. It was first written in Processing, later rewritten in JavaScript. A Leap Motion is used for tracking.

### Processing

![Collision Detection](/Readme/collision.png)
*Collsion detection*

To make the game run in Processing at an acceptable framerate we used Multi-Threading and a self-written performance-optimized collision detection algorithm (based on [Geomerative](http://www.ricardmarxer.com/geomerative/)). The swarm is created by a self-developed particle system with a small amount of swarm-intelligence (the particles are aware of each other and try to mimic one another’s movements.)

![Swarm Communication](/Readme/swarm.png)
*Communication within the swarm visualized*

### JavaScript

The JavaScript-Version is currently still in development.