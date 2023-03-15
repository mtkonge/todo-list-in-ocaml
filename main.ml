
let help = 
"help
create [title] [content]
delete [id]
list
read [id]
edit [id]"

let getargs inp = Str.split (Str.regexp " ") inp

let rec todo () =
    let () = print_string "\nWelcome to the todo list: " in
      let inp = read_line() in
        let args = getargs inp in
          let command = List.nth args 0 in
            if command = "help" then
              let () = print_string help in todo ()
            else if command = "create" then
              todo ();;
todo ()

