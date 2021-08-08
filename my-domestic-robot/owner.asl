!desligar(lamp). // fonte source
!get(beer).   // initial goal: get a beer
!check_bored. // initial goal: verify whether I am getting bored


+!get(beer) : true
   <- .send(robot, achieve, has(owner,beer)). //.send(robot, tell, off(lights)).

   
+!desligar(lamp) : true
   <- .suspend(get(beer)); // isso nao estava aqui .suspend(current_intention(I));//
   	  .send(robot, achieve, off(lights));
	  .wait(1000);// isso nao estava aqui
	  .resume(get(beer));// isso nao estava aqui resume(current_intention(I));//
	  !desligar(lamp).
   
	  
+has(owner,beer) : true
   <- !drink(beer).
-has(owner,beer) : true
   <- !get(beer).

// while I have beer, sip
+!drink(beer) : has(owner,beer)
   <- sip(beer);
     !drink(beer).
+!drink(beer) : not has(owner,beer)
   <- true.

+!check_bored : true
   <- .random(X); .wait(X*5000+2000);  // i get bored at random times
      .send(robot, askOne, time(_), R); // when bored, I ask the robot about the time
      .print(R);
      !check_bored.

+msg(M)[source(Ag)] : true
   <- .print("Message from ",Ag,": ",M);
      -msg(M).
