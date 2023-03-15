let help = ""

let rec todo repeat =
  if not repeat then
    () 
  else 
    let () = print_string "\n Welcome to the todo list: " in
      let inp = read_line() in
        if inp = "help" then
          let () = print_string help in todo repeat;;

todo true
       


