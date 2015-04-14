 
/*
FINITE STATE MACHINE AI
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 A "finite state machine" or FSM is a way of conceptualizing an 
 entity that has specific and discreet states - in other words, the 
 object can only have one state at a time. With well-chosen states,
 we can create complex-seeming behavior that can mimic physical
 conditions (how the entity moves) or emotional states (angry, curious,
 idle).
 
 For example, we can think of a zombie, but you can substitute the 
 "attack" langauge for any other kind of behavior. Here are some common
 game AI states:
 
   IDLE          just stays still, only aware if something engages it directly
   AWARE         searches for intruders, notices things like open doors
   INTRIGUED     knows something is happening, abandons path to seek
   ALERT         aware of the player and begins hunting them down
   AGGRESSIVE    actively attacking the player
   FLEEING       runs away from the player
   DEAD          no longer aware, but may be revived (depending on the game)
 
 Let's simplify our system a bit. By combining triggers with the resulting
 action, we have what's called a State/Even Table:
   1. idle until player is within a certain range
   2. if within range, moves towards the player
   3. if close enough, attacks
   4. when attack is finished, flee from the player
 
 Implementing this in code is easier than you'd think – we just need
 some if/else statements to control the behavior. This example uses 
 the PVector class, so if you haven't read about that yet, take a look
 at the Processing examples, or the "SeekAndFlee" example here.
 
 For a much more detailed description of FSM AI, see:
 +  http://en.wikipedia.org/wiki/Finite-state_machine
 +  https://software.intel.com/en-us/articles/designing-artificial-intelligence-for-games-part-1
 +  http://gamedevelopment.tutsplus.com/tutorials/finite-state-machines-theory-and-implementation--gamedev-11867
 
 CHALLENGE:
 +  Can you trigger the "flee" state to be triggered when the player
    attacks, maybe by clicking or hitting the spacebar?
 +  Can you give the zombie a better "idle" state? Hint: try "sin()"
 +  Can you make lots of zombies who all "listen" to each other and change
    states based on the state of their neighbor? For example, if one zombie
    is in "seek" mode, all zombies seek to the target. It will likely help
    if you convert this code to an object-oriented approach.
 
 */

float zombieIdleSpeed =   2;          // how fast can the zombie move?
float zombieRunSpeed =    4;          // diff speeds give more nuanced behavior
float zombieAttackSpeed = 6;
color zombieColor =       color(0);   // change color depending on the state

int idle =    0;                      // states could just be #s, but giving
int seek =    1;                      // them names makes them easier to track
int attack =  2;
int flee =    4;
int state =   idle;                   // set initial state to idle

PVector player, zombie;               // positions, set in setup()


void setup() {
  size(600,600);
  cursor(CROSS);
  
  // initial positions, use the mouse to move
  player = new PVector(50, 50);
  zombie = new PVector(width/2, height/2);
}

void draw() {
  background(230);
  
  // draw player and update the position
  fill(0,150,255);
  noStroke();
  ellipse(player.x, player.y, 40,40);
  player.x = mouseX;
  player.y = mouseY;
  
  // set the zombie's state depending on distance
  float dist = player.dist(zombie);
  if (dist > 300) state = idle;          // further than 300px, wander
  else if (dist < 20) state = flee;      // close enough to touch you, run away
  
  // if we're not currently fleeing but we're within range,
  // either seek or attack
  if (state != flee) {
    if (dist <= 300 && dist > 100) state = seek;
    else if (dist <= 100) state = attack;
  }
  
  // based on current state of the zombie, exhibit different
  // behavior and change color to indicate the state
  
  // randomly wander about, looking for the player
  // note: you could code a random idle movement if you wanted
  if (state == idle) {  
    zombie.x += random(-zombieIdleSpeed, zombieIdleSpeed);
    zombie.y += random(-zombieIdleSpeed, zombieIdleSpeed);
    zombieColor = color(0);
  }
  
  // normal seek AI behavior – for a description, see the
  // "SeekAndFlee" example in this repo
  else if (state == seek) {
    PVector direction = PVector.sub(player, zombie);
    direction.normalize();
    direction.mult(zombieRunSpeed);
    zombie.add(direction);
    zombieColor = color(150,0,0);    // dark red
  }
  
  // attack state is like seek, but at a different speed (set at top)
  else if (state == attack) {
    PVector direction = PVector.sub(player, zombie);
    direction.normalize();
    direction.mult(zombieAttackSpeed);
    zombie.add(direction);
    zombieColor = color(255,0,0);    // angry bright red!
  }
  
  // flee is the opposite of seek - subtract to move away
  else if (state == flee) {
    PVector direction = PVector.sub(player, zombie);
    direction.normalize();
    direction.mult(zombieRunSpeed);
    zombie.sub(direction);
    zombieColor = color(100);        // a cowardly blue-green
  }
  
  // draw the zombie
  fill(zombieColor);
  ellipse(zombie.x, zombie.y, 40,40);
}



