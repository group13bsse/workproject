run.model <- function(time, switch) {
  # Runs the Model
  #
  # Args:
  #   time: Number of iterations 
  #   switch: Boolean of switching strategy 
  # Returns:
  #   WinRate (wins/time)
  #
  
  # number of wins counter
  wins <- c(0)
  
  for (i in 1:time) {
    # get a random ordering of 1,2,3 - 3 represents the FERRARI
    objs <- sample(1:3)
    
    # since its randomly distriubted, KISS, we will always initially pick the first door
    pick <- objs[1]
    
    # reveal a goat-door: choose a SINGLE door that isn't the original pick and isn't the car, and remove it from the set
    reveal <- objs[objs != pick & objs < 3]   # reveal is copy of objs (WHERE obj != pick AND obj < 3)
    reveal <- reveal[1]                       # need this line in case reveal is both 1 and 2 
    objs <- objs[objs != reveal]              # objs is now a copy of itself, minus the single revealed goat-door
    
    # implement strategy
    if (switch) {
      newPick <- objs[objs != pick]
    } else {
      newPick <- pick
    }
    
    # win or lose!
    if (newPick == 3) {
      wins = wins + 1
    } 
  }
  
  message ("Switch Strategy:", switch)
  message ("Total Wins: ", wins)
  message ("Out of ", time)
  
  return(wins/time)
}

switchWinRate <- run.model(1000, TRUE) # Switch TRUE
switchWinRate

noSwitchWinRate <- run.model(1000, FALSE) # Switch FALSE
noSwitchWinRate

