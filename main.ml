
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
            match command with
            | "help" -> print_string help; todo ()
            | "create" -> todo ()
            | "delete" -> todo ()
            | "list" -> todo ()
            | "read" -> todo ()
            | "edit" -> todo ()
            | _ -> let () = print_string "Could find command, type 'help' for all commands" in todo ();;

todo ()