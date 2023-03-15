

let help = 
"help
create [title] [content]
delete [id]
list
read [id]
edit [id]"

let getargs inp = Str.split (Str.regexp " ") inp

let rec todo repeat =
  if not repeat then
    () 
  else 
    let () = print_string "\nWelcome to the todo list: " in
      let inp = read_line() in
        let args = getargs inp in
          let command = List.nth args 1 in
            if command = "help" then
              let () = print_string help in todo repeat
            else if command = "create" then
              todo repeat;;
todo true
       


